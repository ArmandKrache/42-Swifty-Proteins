import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swifty_companion/src/config/app_assets.dart';
import 'package:swifty_companion/src/config/app_colors.dart';
import 'package:swifty_companion/src/config/config.dart';
import 'package:swifty_companion/src/config/router/app_router.dart';
import 'package:swifty_companion/src/domain/models/coalition/coalition.dart';
import 'package:swifty_companion/src/domain/models/cursus.dart';
import 'package:swifty_companion/src/domain/models/project.dart';
import 'package:swifty_companion/src/domain/models/student/student_details.dart';
import 'package:swifty_companion/src/presentation/cubits/student/student_cubit.dart';
import 'package:swifty_companion/src/presentation/widgets/coalition_banner.dart';
import 'package:swifty_companion/src/utils/coalition_functions.dart';

@RoutePage()
class StudentView extends HookWidget {
  final String studentId;

  const StudentView({super.key, required this.studentId});


  @override
  Widget build(BuildContext context) {
    final studentCubit = BlocProvider.of<StudentCubit>(context);
    CoalitionType coalition = CoalitionType.order;

    useEffect(() {
      studentCubit.getStudentDetails(id: studentId);
      return ;
    }, const []);

    return Scaffold(
      body: SafeArea(
        top: false,
        child: BlocBuilder<StudentCubit, StudentState>(
            builder: (context, state) {
              if (state.runtimeType == StudentFailed) {
                return const Center(
                  heightFactor: 50,
                  child: Text("Student couldn't be loaded"),
                );
              } else if (state.runtimeType == StudentLoading && state.student == null) {
                return const Center(
                  heightFactor: 50,
                  child: Center(child: CupertinoActivityIndicator())
                );
              } else {
                return _buildUserDetailsBody(context, state.student!, coalition);
              }
            }),
      ),
    );
  }

  Widget _buildUserDetailsBody(BuildContext context, StudentDetails student, CoalitionType coalition2) {
    CoalitionType coalition = student.coalition.coalition;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                height: 98 + MediaQuery.of(context).padding.top,
                child: Image.asset(getCoalitionBackground(coalition), fit: BoxFit.cover,),
              ),
              Transform.translate(
                offset: const Offset(0, -5),
                child: LinearPercentIndicator(
                  lineHeight: 10,
                  progressColor: getCoalitionColor(student.coalition.coalition),
                  backgroundColor: Colors.transparent,
                  percent: student.cursus.level - student.cursus.level.toInt(),
                  padding: EdgeInsets.zero,
                  barRadius: const Radius.circular(4),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_formatLevelAndXp(student.cursus.level), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),),
                  ],
                ),
              ),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(256),
                      child: Image.network(student.picture,
                        width: 196,
                        height: 196,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Container(
                            width: 196,
                            height: 196,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(256),
                              color: Colors.grey.withOpacity(0.5)
                            ),
                            child: const Center(
                              child: Icon(Icons.person, size: 96, color: Colors.grey,),
                            ),
                          );
                        },
                      )
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Center(
                    child: Text(student.displayName,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Center(
                    child: Text("(${student.login})",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Center(
                    child: Text(student.location,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 64,
                        child: Column(
                          children: [
                            Text("${student.wallet}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                            const SizedBox(height: 4,),
                            const Text("Wallet", style: TextStyle(color: Colors.black87, fontSize: 12),)
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          CoalitionBannerWidget(
                            coalition: student.coalition,
                            titleVisibility: false,
                            scoreVisibility: false,
                            width: 40,
                            height: 56,
                          ),
                          const SizedBox(height: 4,),
                          Text(getCoalitionTitle(coalition), style: TextStyle(color: getCoalitionColor(student.coalition.coalition), fontSize: 12, fontWeight: FontWeight.bold,),)
                        ],
                      ),
                      SizedBox(
                        width: 64,
                        child: Column(
                          children: [
                            Text("${student.correctionPoints}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                            const SizedBox(height: 4,),
                            const Text("Evaluation points",
                              style: TextStyle(color: Colors.black87, fontSize: 12),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  _buildProjectsWidget(student),
                  const SizedBox(height: 24),
                  _buildSkillsWidget(student),
                  const SizedBox(height: 24),
                  ..._buildContactWidgets(student),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    appRouter.pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 16),
                      child: Icon(Icons.clear, size: 28, color: Colors.white,)
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProjectsWidget(StudentDetails student) {

    List<Project> projects = student.projects.where((element) => (element.cursusId == 21)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Projects", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
        const SizedBox(height: 8,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < projects.length; i++)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  padding: const EdgeInsets.all(2),
                  width: 192,
                  height: 192,
                  decoration: BoxDecoration(
                    color: AppColors.getProjectColor(projects[i].status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(projects[i].name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Center(child: Text(projects[i].mark.toString(),
                        style: TextStyle(color: AppColors.getProjectColor(projects[i].status), fontWeight: FontWeight.bold, fontSize: 32),
                      )),
                      Align(
                        alignment: Alignment.centerRight,
                          child: Text(projects[i].status, style: TextStyle(color: AppColors.getProjectColor(projects[i].status), fontWeight: FontWeight.bold),)
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsWidget(StudentDetails student) {

    bool noData = false;

    if (student.cursus.skills.isEmpty) {
      noData = true;
    }

    List<RadarDataSet> dataSets = [];
    List<RadarEntry> skillsEntries = [];
    List<RadarEntry> maxEntries = [];
    for (int i = 0; i < student.cursus.skills.length; i++) {
      logger.d(student.cursus.skills[i].name);
      logger.d(student.cursus.skills[i].level);
      skillsEntries.add(RadarEntry(value: student.cursus.skills[i].level));
      maxEntries.add(const RadarEntry(value: 21));
    }
    dataSets = [
      RadarDataSet(
      fillColor: Colors.transparent,
      borderColor: Colors.transparent,
      entryRadius: 2,
      dataEntries: maxEntries,
      borderWidth: 2,
    ),RadarDataSet(
      fillColor: AppColors.primary.withOpacity(0.15),
      borderColor: AppColors.primary.withOpacity(0.45),
      entryRadius: 2,
      dataEntries: skillsEntries,
      borderWidth: 2,
    ),];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Skills", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
        const SizedBox(height: 4,),
        noData ? const Center(child: Text("No Data found", style: TextStyle(color: Colors.grey),),)  :
        Center(
          child: AspectRatio(
            aspectRatio: 1.3,
            child: RadarChart(
              RadarChartData(
                dataSets: dataSets,
                radarBackgroundColor: Colors.transparent,
                borderData: FlBorderData(show: false),
                radarBorderData: const BorderSide(color: Colors.transparent),
                titlePositionPercentageOffset: 0.2,
                titleTextStyle: const TextStyle(fontSize: 10),
                getTitle: (index, angle) {
                  return RadarChartTitle(text: "${student.cursus.skills[index].name}\n${student.cursus.skills[index].level.toStringAsPrecision(2)}",);
                },
                tickCount: 5,
                ticksTextStyle:
                const TextStyle(color: Colors.transparent, fontSize: 10),
                tickBorderData: const BorderSide(color: Colors.transparent),
                gridBorderData: BorderSide(width: 1, color: Colors.grey.withOpacity(0.5)),
              ),
              swapAnimationDuration: const Duration(milliseconds: 400),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildContactWidgets(StudentDetails student) {
    return [
      const Text("Contact", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
      const SizedBox(height: 4,),
      Card(
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                  text: "",
                  style: const TextStyle(color: Colors.black),
                  children: [
                    const TextSpan(text: "Phone", style: TextStyle(decoration: TextDecoration.underline)),
                    TextSpan(text: ": ${student.phone}"),
                  ],
                )),
            const SizedBox(height: 2,),
            RichText(
                text: TextSpan(
                  text: "",
                  style: const TextStyle(color: Colors.black),
                  children: [
                    const TextSpan(text: "Email", style: TextStyle(decoration: TextDecoration.underline)),
                    TextSpan(text: ": ${student.email }"),
                  ],
                )),
          ],
        ),
      ),
    ];
  }
}

String _formatLevelAndXp(double total) {
  int level = total.toInt();
  int xp = ((total - level) * 100).round();
  return "Level $level - $xp%";
}