import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/pressing/pressing_model.dart';
import 'package:movegui/providers/providers.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/services/pressing_service.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/services/user_service.dart';
import 'package:movegui/widgets/store/store_widget.dart';


class PressingScreen extends ConsumerStatefulWidget {
  const PressingScreen({super.key,});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => PressingScreenState();
  }



class PressingScreenState extends ConsumerState<PressingScreen> {
  late TextEditingController searchTextController;
  List<PressingModel> pressings = [];
  late PressingService pressingService;
  late UserService userService;
  final pressingConstants = PressingConstants();

  @override
  void initState() {
    searchTextController = TextEditingController();
    pressingService = getIt<PressingService>();
        userService = getIt<UserService>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(appbarTitleProviderState).setTitle(AppLocalizations.of(context)!.pressing_title);
      await userService.initUser(ref);
      await  initList();
    });
   
    super.initState();
  }


  Future<void> initList() async {
    final allPressings = await pressingService.allModels();
    setState(() {
      pressings = allPressings;
    });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // or Colors.white
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Responsive.isDesktop(context) ? buildDesktop() : buildMobil(),
          ),
        ),
      ),
    );
  }

  Widget buildMobil() {
    return Column(
      children: [
        const SizedBox(height: 15),

        TextField(
          controller: searchTextController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            suffixIcon: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                searchTextController.clear();
              },
              child: const Icon(Icons.clear, color: Colors.red),
            ),
          ),
        ),

        const SizedBox(height: 4),

        Expanded(
          child: DynamicHeightGridView(
            itemCount: pressings.length,
            crossAxisCount: 1,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            builder: (context, index) {
              return StoreWidget(
                model: pressings[index],
                catgory: AppConstants.CATEGORY_PRESSING,
                //      navigatorKey: widget.navigatorKey,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildDesktop() {
    return Column(
      children: [
        const SizedBox(height: 15),
        Expanded(
          child: DynamicHeightGridView(
            itemCount: pressings.length,
            crossAxisCount: 3,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            builder: (context, index) {
              return StoreWidget(
                model: pressings[index],
                catgory: AppConstants.CATEGORY_PRESSING,
                // navigatorKey: widget.navigatorKey,
              );
            },
          ),
        ),
      ],
    );
  }
}
