import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:swifty_proteins/src/config/app_colors.dart';
import 'package:swifty_proteins/src/config/config.dart';
import 'package:swifty_proteins/src/config/router/app_router.dart';
import 'package:swifty_proteins/src/presentation/cubits/homepage/homepage_cubit.dart';
import 'package:swifty_proteins/src/presentation/widgets/options_dialog.dart';
import 'package:swifty_proteins/src/presentation/widgets/search_bar_widget.dart';
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
    final TextEditingController searchController = useTextEditingController();
    final query = useState<String>("");
    final isFirstBuild = useState<bool>(true);


    useEffect(() {
      homepageCubit.initData();
      return;
    }, const []);

    useEffect(() {
      if (!isFirstBuild.value) {
        homepageCubit.rebuild();
      } else {
        isFirstBuild.value = false;
      }
      return;
    }, [query.value]);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.centerLeft,
          child: CustomSearchBar(
            controller: searchController,
            onChanged: (newQuery) async {
              query.value = newQuery;
            },
            margin: const EdgeInsets.all(8),
            width: 256,
            hintText: tr("homepage.filter_by_name"),
            leading: null,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () async {
                logger.d(context.locale.languageCode);
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return OptionsDialog(
                      logout: () {
                        homepageCubit.logOut();
                      },
                    );
                  },
                );
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: const Icon(Icons.settings, color: Colors.black54,),
                ),
              ),
            ),
          )
        ],
        toolbarHeight: 80,
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
              return _buildBody(homepageCubit, searchController, query.value);
            }
        }
      )
    );
  }

  Widget _buildBody(HomepageCubit homepageCubit, TextEditingController searchController, String query) {
    return SafeArea(
      left: false,
      right: false,
      child: Column(
        children: [
          _buildStudentSearchWidget(homepageCubit, searchController),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24,),
                  _buildLigandsListWidget(homepageCubit.state.ligands ?? [], query)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLigandsListWidget(List<String> ligands, String query) {
    List<String> filteredList = ligands;
    if (query != "" ) {
      filteredList = ligands.where((item) => item.contains(query)).toList();
    }
    return Wrap(
      runSpacing: 16,
      spacing: 16,
      children: [
        for (int i = 0; i < filteredList.length; i++)
          _ligandCard(filteredList[i])
      ],
    );
  }

  Widget _ligandCard(String name) {
    return GestureDetector(
      onTap: () {
        appRouter.push(LigandRoute(ligandId: name));
      },
      child: Container(
        width: 64,
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.withOpacity(0.3)
        ),
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Text(name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }


  Widget _buildStudentSearchWidget(HomepageCubit homepageCubit, TextEditingController searchController) {
    return Material(
      elevation: 4,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black87.withOpacity(0.25),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8, bottom: 24),
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4,),
              BlocBuilder<HomepageCubit, HomepageState>(
                builder: (context, state) {
                  if (state.runtimeType == HomepageLoading) {
                    return const Center(child: CupertinoActivityIndicator());
                  }
                  return const SizedBox();
                }
                ),
            ],
          ),
        ),
      ),
    );
  }

}