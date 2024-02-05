import 'package:flutter_gl/flutter_gl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

const storage = FlutterSecureStorage();
final logger = Logger();

Future<void> initGL() async {
  int width = 200;
  int height = 200;
  num dpr = 1.0;

  FlutterGlPlugin flutterGlPlugin = FlutterGlPlugin();

  Map<String, dynamic> _options = {
    "width": width,
    "height": height,
    "dpr": dpr,
    "antialias": true,
    "alpha": false
  };
  await flutterGlPlugin.initialize(options: _options);

// on web this need called after web canvas dom was added to document
  await flutterGlPlugin.prepareContext();

// you can get gl by
  dynamic gl = flutterGlPlugin.gl;

// then you can call OpenGL ES API by gl like
  gl.clearColor(0.0, 0.0, 0.0, 1.0);
  gl.clear(gl.COLOR_BUFFER_BIT);

// use this method to notify Flutter update Texture Widget
// sourceTextue is a texture which bind to FBO framebuffer
  ///flutterGlPlugin.updateTexture(sourceTexture);
}