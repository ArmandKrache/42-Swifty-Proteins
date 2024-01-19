import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swifty_companion/src/config/app_assets.dart';
import 'package:swifty_companion/src/config/app_colors.dart';
import 'package:swifty_companion/src/config/router/app_router.dart';
import 'package:swifty_companion/src/domain/models/coalition/coalition.dart';
import 'package:swifty_companion/src/presentation/cubits/remote_articles/homepage_cubit.dart';
import 'package:swifty_companion/src/presentation/widgets/coalition_banner.dart';
import 'package:swifty_companion/src/presentation/widgets/event_card.dart';
import 'package:swifty_companion/src/presentation/widgets/search_bar_widget.dart';
import 'package:swifty_companion/src/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
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

    }, const []);

    return Scaffold(
      body: BlocBuilder<HomepageCubit, HomepageState>(
        builder: (_, state) {
          switch (state.runtimeType) {
            case HomepageLoading:
              return const Center(child: CupertinoActivityIndicator());
            case HomepageFailed:
              return const Center(child: Icon(Icons.refresh));
            case HomepageSuccess:
              return _buildBody(homepageCubit, searchController);
            default:
              return const SizedBox();
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
            _buildAgendaWidget(),
            const SizedBox(height: 16,),
            _buildCoalitionsWidget(),
            const SizedBox(height: 24,),
            GestureDetector(
              onTap: () {
                homepageCubit.logOut();
              },
              child: const Center(child: Text("Logout",
                style: TextStyle(color: AppColors.alert, fontWeight: FontWeight.bold, fontSize: 16  ),)
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStudentSearchWidget(HomepageCubit homepageCubit, TextEditingController searchController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Search students by login", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
          CustomSearchBar(
            controller: searchController,
            onChanged: (query) async {
              /// Search student
            },
            margin: const EdgeInsets.all(8),
            width: double.maxFinite,
          ),
          const SizedBox(height: 4,),
          BlocBuilder<HomepageCubit, HomepageState>(
              builder: (context, state) {
                /*
                if (state.student) {
                  return const Center(child: Text("Drinks list is empty"),);
                } else {
                  return _buildDataWidgets(state.drinks, homepageCubit, () {rebuildFlag.value = true;});
                }*/
                /// If student found
                return Center(
                  child: GestureDetector(
                    onTap: () {
                      /// Handle Navigation to Student view
                      appRouter.push(const StudentRoute());
                    },
                    child: Column(
                      children: [
                        Image.network("https://cdn.intra.42.fr/users/0a2d11f83d8ac572eedab592adcaa3f8/akrache.jpg", width: 128,),
                        const SizedBox(height: 2,),
                        const Text("akrache",
                          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                );

                /// Else If no results AND query is not empty
                return const Center(child: Text("0 results matched for [query]"),);
                /// Else
                return const SizedBox();
              }),
        ],
      ),
    );
  }

  Widget _buildCoalitionsWidget() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Coalitions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          SizedBox(height: 8,),
          Center(
            child: Wrap(
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              runSpacing: 8,
              spacing: 8,
              children: [
                CoalitionBannerWidget(coalition: Coalition(id: 0, name: "Order", score: 7777, coalition: CoalitionType.order), width: 72,),
                CoalitionBannerWidget(coalition: Coalition(id: 0, name: "Alliance", score: 88812, coalition: CoalitionType.alliance), width: 72,),
                CoalitionBannerWidget(coalition: Coalition(id: 0, name: "Assembly", score: 4242, coalition: CoalitionType.assembly), width: 72,),
                CoalitionBannerWidget(coalition: Coalition(id: 0, name: "Federation", score: 667, coalition: CoalitionType.federation), width: 72,),
              ],
            ),
          )

        ],
      ),
    );
  }

  Widget _buildAgendaWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Agenda", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          const SizedBox(height: 4,),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: 298,
              child: ListView.builder(
                itemCount: 10, // Adjust this based on your actual item count
                itemBuilder: (context, index) {
                  return const EventCardWidget();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}