import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swifty_proteins/src/config/app_assets.dart';
import 'package:swifty_proteins/src/config/app_colors.dart';
import 'package:swifty_proteins/src/config/app_strings.dart';
import 'package:swifty_proteins/src/config/config.dart';
import 'package:swifty_proteins/src/config/router/app_router.dart';
import 'package:swifty_proteins/src/domain/models/coalition/coalition.dart';
import 'package:swifty_proteins/src/domain/models/cursus.dart';
import 'package:swifty_proteins/src/domain/models/project.dart';
import 'package:swifty_proteins/src/domain/models/student/student_details.dart';
import 'package:swifty_proteins/src/presentation/cubits/ligand/ligand_cubit.dart';
import 'package:swifty_proteins/src/presentation/widgets/coalition_banner.dart';
import 'package:swifty_proteins/src/utils/coalition_functions.dart';

@RoutePage()
class LigandView extends HookWidget {
  final String ligandId;

  const LigandView({super.key, required this.ligandId});


  @override
  Widget build(BuildContext context) {
    final ligandCubit = BlocProvider.of<LigandCubit>(context);

    useEffect(() {
      ligandCubit.getLigand(id: ligandId);
      return ;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: Text(ligandId),
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<LigandCubit, LigandState>(
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
                return const SizedBox();
              }
            }),
      ),
    );
  }
}