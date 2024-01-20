import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:swifty_companion/src/config/app_colors.dart';
import 'package:swifty_companion/src/config/router/app_router.dart';
import 'package:swifty_companion/src/domain/models/coalition/coalition.dart';
import 'package:swifty_companion/src/domain/models/event/event.dart';
import 'package:swifty_companion/src/domain/models/student/student.dart';
import 'package:swifty_companion/src/presentation/cubits/remote_articles/homepage_cubit.dart';
import 'package:swifty_companion/src/presentation/widgets/coalition_banner.dart';
import 'package:swifty_companion/src/presentation/widgets/event_card.dart';
import 'package:swifty_companion/src/presentation/widgets/search_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class HomepageView extends HookWidget {
  const HomepageView({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    final homepageCubit = BlocProvider.of<HomepageCubit>(context);
    final TextEditingController searchController = TextEditingController();

    useEffect(() {
      homepageCubit.fetchData();
      return;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomSearchBar(
          controller: searchController,
          onChanged: (query) async {
            if (query != "") {
              homepageCubit.searchStudent(query: query);
            }
          },
          margin: const EdgeInsets.all(8),
          width: double.maxFinite,
          hintText: tr("homepage.search_student_by_login"),
        ),toolbarHeight: 80,
      ),
      body: BlocBuilder<HomepageCubit, HomepageState>(
        builder: (_, state) {
            if (state.runtimeType == HomepageLoading) {
              return const Center(child: CupertinoActivityIndicator());
            }
            else if (state.runtimeType == HomepageFailed) {
              return const Center(child: Icon(Icons.refresh));
            }
            else {
              return _buildBody(homepageCubit, searchController);
            }
        }
      )
    );
  }

  Widget _buildBody(HomepageCubit homepageCubit, TextEditingController searchController) {
    return SingleChildScrollView(
      child: SafeArea(
        left: false,
        right: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStudentSearchWidget(homepageCubit, searchController),
            const SizedBox(height: 16,),
            _buildCoalitionsWidget(homepageCubit),
            const SizedBox(height: 16,),
            _buildEventsWidget(homepageCubit),
            const SizedBox(height: 24,),
            GestureDetector(
              onTap: () {
                homepageCubit.logOut();
              },
              child: Center(child: Text(tr("homepage.logout"),
                style: const TextStyle(color: AppColors.alert, fontWeight: FontWeight.bold, fontSize: 16  ),)
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStudentSearchWidget(HomepageCubit homepageCubit, TextEditingController searchController) {
    List<Student> students = homepageCubit.state.students ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4,),
          BlocBuilder<HomepageCubit, HomepageState>(
              builder: (context, state) {
                if (state.runtimeType == HomepageSearchLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                }
                if (students.isEmpty && searchController.text != "") {
                  return Center(
                    child: Text("${tr("errors.0_results_for_given_query")}: ${searchController.text}",
                      style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  );
                }
                return Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < students.length; i++)
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            child: GestureDetector(
                            onTap: () {
                              appRouter.push(StudentRoute(studentId: students[i].id.toString()));
                            },
                            child: Column(
                              children: [
                                Image.network(students[i].picture, width: 128, height: 160,
                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                  return Center(
                                      child: Container(
                                        width: 128,
                                        height: 160,
                                        color: Colors.grey.withOpacity(0.3),
                                          child: const Icon(Icons.person, size: 64, color: Colors.grey,)
                                      ));
                                  },
                                ),
                                const SizedBox(height: 2,),
                                Text(students[i].login,
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 15),
                                )
                              ],
                            ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget _buildCoalitionsWidget(HomepageCubit homepageCubit) {
    List<Coalition>? coalitions = homepageCubit.state.coalitions;
    if (coalitions == null) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tr("coalitions.coalitions"), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          const SizedBox(height: 8,),
          Center(
            child: Wrap(
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              runSpacing: 8,
              spacing: 8,
              children: [
                for (int i = 0; i < coalitions.length; i++)
                  CoalitionBannerWidget(
                    coalition: coalitions[i],
                    width: 72,
                  ),
              ],
            ),
          )

        ],
      ),
    );
  }

  Widget _buildEventsWidget(HomepageCubit homepageCubit) {
    List<Event>? events = homepageCubit.state.events;
    if (events == null) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tr("homepage.events"), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          const SizedBox(height: 4,),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: 298,
              child: ListView.builder(
                itemCount: events.length, // Adjust this based on your actual item count
                itemBuilder: (context, index) {
                  return EventCardWidget(event: events[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}