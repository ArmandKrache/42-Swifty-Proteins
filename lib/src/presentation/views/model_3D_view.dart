import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gl/flutter_gl.dart';
import 'package:swifty_proteins/src/config/app_colors.dart';
import 'package:swifty_proteins/src/config/router/app_router.dart';
import 'package:swifty_proteins/src/domain/models/atom.dart';
import 'package:swifty_proteins/src/domain/models/bond.dart';
import 'package:swifty_proteins/src/domain/models/ligand/ligand.dart';
import 'package:swifty_proteins/src/utils/extensions/custom_vector3.dart';
import 'package:three_dart/three3d/objects/mesh.dart';

import 'package:three_dart/three_dart.dart' as three;
import 'package:three_dart_jsm/three_dart_jsm.dart' as three_jsm;

@RoutePage()
class Model3DView extends StatefulWidget {
  final Ligand ligand;

  const Model3DView({Key? key, required this.ligand}) : super(key: key);

  @override
  State<Model3DView> createState() => _Model3DViewState();
}

class _Model3DViewState extends State<Model3DView> {
  late FlutterGlPlugin three3dRender;
  three.WebGLRenderer? renderer;
  List<Map<String, dynamic>> atomsMeshes = [];

  int? fboId;
  late double width;
  late double height;

  Size? screenSize;

  late three.Scene scene;
  late three.Camera camera;
  late three.Mesh mesh;

  double dpr = 1.0;

  var amount = 4;

  bool verbose = false;
  bool disposed = false;

  late three.WebGLRenderTarget renderTarget;

  dynamic sourceTexture;

  final GlobalKey<three_jsm.DomLikeListenableState> _globalKey = GlobalKey<three_jsm.DomLikeListenableState>();

  late three_jsm.TrackballControls controls;

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    width = screenSize!.width;
    height = screenSize!.height - 60;

    three3dRender = FlutterGlPlugin();

    Map<String, dynamic> options = {
      "antialias": true,
      "alpha": false,
      "width": width.toInt(),
      "height": height.toInt(),
      "dpr": dpr
    };

    await three3dRender.initialize(options: options);

    setState(() {});

    Future.delayed(const Duration(milliseconds: 100), () async {
      await three3dRender.prepareContext();

      initScene();
    });
  }

  initSize(BuildContext context) {
    if (screenSize != null) {
      return;
    }

    final mqd = MediaQuery.of(context);

    screenSize = mqd.size;
    dpr = mqd.devicePixelRatio;

    initPlatformState();
  }

  Future<void> reset() async {
    camera.position.set(20, 20, 20);
    camera.lookAt(scene.position);

    render();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          initSize(context);
          return _build(context);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text("Reset"),
        onPressed: () async {
          await reset();
          setState(() {});
        },
      ),
    );
  }

  Widget _build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: _handleTapDown,
      child: three_jsm.DomLikeListenable(
          key: _globalKey,
          builder: (BuildContext context) {
            return Container(
                width: double.maxFinite,
                height: double.maxFinite,
                color: Colors.black,
                child: Builder(builder: (BuildContext context) {
                  if (kIsWeb) {
                    return three3dRender.isInitialized
                        ? HtmlElementView(viewType: three3dRender.textureId!.toString())
                        : Container();
                  } else {
                    return three3dRender.isInitialized
                        ? Texture(textureId: three3dRender.textureId!)
                        : Container();
                  }
                }));
          }),
    );
  }

  render() {
    int t = DateTime.now().millisecondsSinceEpoch;
    final gl = three3dRender.gl;

    controls.update();

    renderer!.render(scene, camera);

    int t1 = DateTime.now().millisecondsSinceEpoch;

    if (verbose) {
      print("render cost: ${t1 - t} ");
      print(renderer!.info.memory);
      print(renderer!.info.render);
    }
    gl.flush();


    if (verbose) print(" render: sourceTexture: $sourceTexture ");

    if (!kIsWeb) {
      three3dRender.updateTexture(sourceTexture);
    }
  }

  initRenderer() {
    Map<String, dynamic> options = {
      "width": width,
      "height": height,
      "gl": three3dRender.gl,
      "antialias": true,
      "canvas": three3dRender.element
    };
    renderer = three.WebGLRenderer(options);
    renderer!.setPixelRatio(dpr);
    renderer!.setSize(width, height, false);
    renderer!.shadowMap.enabled = false;

    if (!kIsWeb) {
      var pars = three.WebGLRenderTargetOptions(
          {"minFilter": three.LinearFilter, "magFilter": three.LinearFilter, "format": three.RGBAFormat});
      renderTarget = three.WebGLRenderTarget((width * dpr).toInt(), (height * dpr).toInt(), pars);
      renderTarget.samples = 4;
      renderer!.setRenderTarget(renderTarget);
      sourceTexture = renderer!.getRenderTargetGLTexture(renderTarget);
    }
  }

  initScene() {
    initRenderer();
    initPage();
  }

  initPage() {
    scene = three.Scene();
    scene.background = three.Color(0xcccccc);
    scene.fog = three.FogExp2(0xcccccc, 0.002);

    camera = three.PerspectiveCamera(60, width / height, 1, 1000);
    camera.position.set(20, 20, 20);
    camera.lookAt(scene.position);

    // controls

    controls = three_jsm.TrackballControls(camera, _globalKey);

    controls.rotateSpeed = 1.0;
    controls.zoomSpeed = 0.9;
    controls.panSpeed = 0.8;

    controls.keys = ['KeyA', 'KeyS', 'KeyD'];

    // world

    var geometry = three.SphereGeometry(0.2);

    List<Atom> atoms = widget.ligand.atoms;
    List<Bond> bonds = widget.ligand.bonds;

    for (var i = 0; i < atoms.length; i++) {
      //var material = three.MeshPhongMaterial({"color": ElementColors.getColorFromString(atoms[i].element).value, "flatShading": false});
      var material = three.MeshPhongMaterial({"color": ElementColors.getColorFromString(atoms[i].element).value, "flatShading": false});
      var mesh = three.Mesh(geometry, material);
      mesh.position.x = atoms[i].position.x;
      mesh.position.y = atoms[i].position.y;
      mesh.position.z = atoms[i].position.z;
      mesh.updateMatrix();
      mesh.matrixAutoUpdate = false;
      scene.add(mesh);
      atomsMeshes.add({"atom" : atoms[i], "mesh" : mesh});
    }

    var materialBonds = three.MeshPhongMaterial({"color": 0xffffff, "flatShading": false});

    for (var i = 0; i < bonds.length; i++) {
      var atom1 = atoms[bonds[i].atom1 - 1];
      var atom2 = atoms[bonds[i].atom2 - 1];


      var position = atom1.position.clone()..add(atom2.position).multiplyScalar(0.5);

      var direction = atom2.position.clone()..sub(atom1.position).normalize();

      var distance = atom1.position.distanceTo(atom2.position);

      //TODO: make different meshes depending on the bond type
      var geometryBonds = three.CylinderGeometry(0.05, 0.05, distance);

      // Create mesh
      var mesh = three.Mesh(geometryBonds, materialBonds);

      // Set position, rotation, and scale
      mesh.position.setFrom(position);
      mesh.quaternion.setFromUnitVectors(three.Vector3(0, 1, 0), direction);
      mesh.scale.set(1, 1, distance);

      scene.add(mesh);
    }

    // lights

    var dirLight1 = three.DirectionalLight(0xffffff);
    dirLight1.position.set(1, 1, 1);
    scene.add(dirLight1);

    var dirLight2 = three.DirectionalLight(0x222288);
    dirLight2.position.set(-1, -1, -1);
    scene.add(dirLight2);

    var ambientLight = three.AmbientLight(0x222222);
    scene.add(ambientLight);

    animate();
  }

  animate() {
    if (!mounted || disposed) {
      return;
    }

    render();

    Future.delayed(const Duration(milliseconds: 40), () {
      animate();
    });
  }

  @override
  void dispose() {
    disposed = true;
    three3dRender.dispose();

    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final hit = _hitTest(details.localPosition, overlay.size);

    if (hit != null) {
      _displayAtomHint(hit);
    }
  }

  Atom? _hitTest(Offset position, Size screenSize) {
    final double x = (position.dx / screenSize.width) * 2 - 1;
    final double y = -(position.dy / screenSize.height) * 2 + 1;

    final raycaster = three.Raycaster();
    raycaster.setFromCamera(three.Vector2(x, y), camera);

    for (final atom in atomsMeshes) {
      final mesh = atom["mesh"];
      final intersects = raycaster.intersectObject(mesh, false);

      if (intersects.isNotEmpty) {
        return atom["atom"];
      }
    }
    return null;
  }

// Function to display a hint for the tapped atom
  void _displayAtomHint(Atom atom) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Atom Details'),
          content: Text('Element: ${atom.element}\nPosition: (${atom.position.x}, ${atom.position.y}, ${atom.position.z})'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}