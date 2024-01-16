import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swifty_companion/src/config/app_assets.dart';
import 'package:swifty_companion/src/config/app_colors.dart';
import 'package:swifty_companion/src/config/router/app_router.dart';

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
              offset: const Offset(0, -5), // Move up by 10 pixels
              child: LinearPercentIndicator(
                lineHeight: 10,
                progressColor: AppColors.order,
                backgroundColor: Colors.transparent,
                percent: 0.9,
                padding: EdgeInsets.zero,
                barRadius: const Radius.circular(4),
              ),
            )
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

  List<Widget> _buildContactWidgets() {
    return [
      const Text("Contact", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
      const SizedBox(height: 4,),
      Card(
        elevation: 0,
        color: Colors.grey.shade200,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                    text: "",
                    style: const TextStyle(color: Colors.black),
                    children: [
                      const TextSpan(text: "Cell", style: TextStyle(decoration: TextDecoration.underline)),
                      TextSpan(text: ": "),
                    ],
                  )),
              RichText(
                  text: TextSpan(
                    text: "",
                    style: const TextStyle(color: Colors.black),
                    children: [
                      const TextSpan(text: "Home", style: TextStyle(decoration: TextDecoration.underline)),
                      TextSpan(text: ": hidden"),
                    ],
                  )),
              RichText(
                  text: TextSpan(
                    text: "",
                    style: const TextStyle(color: Colors.black),
                    children: [
                      const TextSpan(text: "Mail", style: TextStyle(decoration: TextDecoration.underline)),
                      TextSpan(text: ": armandkrache@gmail.com"),
                    ],
                  )),
            ],
          ),
        ),
      ),
    ];
  }
}
