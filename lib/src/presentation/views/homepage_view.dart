import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swifty_companion/src/config/app_assets.dart';
import 'package:swifty_companion/src/config/router/app_router.dart';
import 'package:swifty_companion/src/presentation/cubits/remote_articles/homepage_cubit.dart';
import 'package:swifty_companion/src/presentation/widgets/CoalitionBanner.dart';
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

    useEffect(() {

    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr("breaking_news.daily_news"),
        style: const TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                homepageCubit.logOut();
              },
              child: const Icon(Icons.logout_outlined, color: Colors.redAccent),
            ),
          )
        ],
      ),
      body: BlocBuilder<HomepageCubit, HomepageState>(
        builder: (_, state) {
          switch (state.runtimeType) {
            case HomepageLoading:
              return const Center(child: CupertinoActivityIndicator());
            case HomepageFailed:
              return const Center(child: Icon(Icons.refresh));
            case HomepageSuccess:
              return _buildBody();
            default:
              return const SizedBox();
          }
        }
      )
    );
  }

  Widget _buildBody() {
    return const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: CoalitionBannerWidget(coalition: Coalition.order)
              ),
              Center(
                  child: CoalitionBannerWidget(coalition: Coalition.alliance)
              ),
            ],
          ),
        )
    );
  }
}