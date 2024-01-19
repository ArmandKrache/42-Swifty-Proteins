import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swifty_companion/src/config/app_assets.dart';
import 'package:swifty_companion/src/config/app_colors.dart';
import 'package:swifty_companion/src/config/router/app_router.dart';
import 'package:swifty_companion/src/domain/models/coalition/coalition.dart';
import 'package:swifty_companion/src/domain/models/cursus.dart';
import 'package:swifty_companion/src/presentation/widgets/coalition_banner.dart';

@RoutePage()
class StudentView extends StatelessWidget {
  //final Student student;

  const StudentView({super.key, /*required this.student*/});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        top: false,
        child: _buildUserDetailsBody(context),
      ),
    );
  }

  Widget _buildUserDetailsBody(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: 98 + MediaQuery.of(context).padding.top,
              child: Image.asset(AppAssets.orderBackground, fit: BoxFit.cover,),
            ),
            Transform.translate(
              offset: const Offset(0, -5),
              child: LinearPercentIndicator(
                lineHeight: 10,
                progressColor: AppColors.order,
                backgroundColor: Colors.transparent,
                percent: 0.94,
                padding: EdgeInsets.zero,
                barRadius: const Radius.circular(4),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -35),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Level 12 - 44%", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),)
                ],
              ),
            ),
          ],
        ),
        SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(256),
                        child: Image.network("https://cdn.intra.42.fr/users/0a2d11f83d8ac572eedab592adcaa3f8/akrache.jpg",
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
                    const Center(
                      child: Text("Armand Krache",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    const Center(
                      child: Text("(akrache)",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    const Center(
                      child: Text("Unavailable",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 64,
                          child: Column(
                            children: [
                              Text("225", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              SizedBox(height: 4,),
                              Text("Wallet", style: TextStyle(color: Colors.black87, fontSize: 12),)
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            CoalitionBannerWidget(
                              coalition: Coalition(coalition: CoalitionType.order,),
                              titleVisibility: false,
                              scoreVisibility: false,
                              width: 40,
                              height: 56,
                            ),
                            SizedBox(height: 4,),
                            Text("The Order", style: TextStyle(color: AppColors.order, fontSize: 12, fontWeight: FontWeight.bold,),)
                          ],
                        ),
                        SizedBox(
                          width: 64,
                          child: Column(
                            children: [
                              Text("3", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              SizedBox(height: 4,),
                              Text("Evaluation points",
                                style: TextStyle(color: Colors.black87, fontSize: 12),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    _buildProjectsWidget(),
                    const SizedBox(height: 16),
                    _buildSkillsWidget(),
                    const SizedBox(height: 16),
                    ..._buildContactWidgets(),
                  ],
                ),
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
    );
  }

  Widget _buildProjectsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Projects", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
        const SizedBox(height: 8,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < 10; i++)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  padding: const EdgeInsets.all(2),
                  width: 192,
                  height: 192,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Part_Time I Company Final Evaluation",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Center(child: Text("125",
                        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 24),
                      )),
                      Align(
                        alignment: Alignment.centerRight,
                          child: Text("finished", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),)
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

  Widget _buildSkillsWidget() {

    List<Skill> skills = [];
    bool noData = false;

    if (skills.isEmpty) {
      noData = true;
    }

    List<RadarDataSet> dataSets = [];
    List<RadarEntry> skillsEntries = [];
    List<RadarEntry> maxEntries = [];
    for (int i = 0; i < skills.length; i++) {

      skillsEntries.add(RadarEntry(value: skills[i].level));
      maxEntries.add(const RadarEntry(value: 21));
    }
    dataSets = [
      RadarDataSet(
      fillColor: Colors.transparent.withOpacity(0.15),
      borderColor: Colors.transparent.withOpacity(0.45),
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
                titleTextStyle: const TextStyle(fontSize: 14),
                getTitle: (index, angle) {
                  return RadarChartTitle(text: skills[index].name);
                },
                tickCount: 1,
                ticksTextStyle:
                const TextStyle(color: Colors.transparent, fontSize: 10),
                tickBorderData: const BorderSide(color: Colors.transparent),
                gridBorderData: const BorderSide( width: 2),
              ),
              swapAnimationDuration: const Duration(milliseconds: 400),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildContactWidgets() {
    return [
      const Text("Contact", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
      const SizedBox(height: 4,),
      Card(
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: const TextSpan(
                  text: "",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(text: "Téléphone", style: TextStyle(decoration: TextDecoration.underline)),
                    TextSpan(text: ": "),
                  ],
                )),
            const SizedBox(height: 2,),
            RichText(
                text: const TextSpan(
                  text: "",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(text: "Adresse", style: TextStyle(decoration: TextDecoration.underline)),
                    TextSpan(text: ": hidden"),
                  ],
                )),
            const SizedBox(height: 2,),
            RichText(
                text: const TextSpan(
                  text: "",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(text: "Email", style: TextStyle(decoration: TextDecoration.underline)),
                    TextSpan(text: ": armandkrache@gmail.com"),
                  ],
                )),
          ],
        ),
      ),
    ];
  }
}