import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:swifty_proteins/src/config/app_colors.dart';
import 'package:swifty_proteins/src/config/router/app_router.dart';
import 'package:swifty_proteins/src/presentation/cubits/ligand/ligand_cubit.dart';
import 'package:swifty_proteins/src/presentation/views/model_3D_view.dart';
import 'package:three_dart/three3d/extras/core/ttf_font.dart';

@RoutePage()
class LigandView extends HookWidget {
  final String ligandId;

  const LigandView({super.key, required this.ligandId});


  @override
  Widget build(BuildContext context) {
    final ligandCubit = BlocProvider.of<LigandCubit>(context);

    useEffect(() {
      ligandCubit.getLigand(ligandId);
      return ;
    }, const []);

    return Scaffold(
      body: BlocBuilder<LigandCubit, LigandState>(
          builder: (context, state) {
            if (state.runtimeType == LigandFailed) {
              return Center(
                heightFactor: 50,
                child: Text(tr("errors.student_not_loaded")),
              );
            } else
            if (state.runtimeType == LigandLoading && state.ligand == null) {
              return const Center(
                  heightFactor: 50,
                  child: Center(child: CupertinoActivityIndicator())
              );
            } else {
              return Stack(
                children: [
                  Model3DView(ligand: state.ligand!,),
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            appRouter.pop();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Icon(Icons.arrow_back_ios, color: Colors.black87,),
                          ),
                        ),
                        Text(ligandId,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            //TODO: Handling sharing feature
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Icon(Icons.share, color: AppColors.primary,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}