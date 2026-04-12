import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/consts/validator.dart';
import 'package:movegui/models/pressing_model.dart';
import 'package:movegui/providers/shopping_provider.dart';
import 'package:movegui/services/pressing_service.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/widgets/custom_text_field.dart';
import 'package:movegui/widgets/menu/menu.dart';
import 'package:movegui/widgets/pressing/pressing_price_list.dart';
import 'package:movegui/widgets/util/image_banner.dart';
import 'package:provider/provider.dart';

class PressingDetailScreen extends StatefulWidget {
  final PressingModel model;
    final GlobalKey<NavigatorState> navigatorKey;

  const PressingDetailScreen({super.key, required this.model, required this.navigatorKey});
  @override
  State<StatefulWidget> createState() => PressingDetailScreenState();
}

class PressingDetailScreenState extends State<PressingDetailScreen> {
  late TextEditingController searchTextController;
  List<PressingModel> pressings = [];
  late PressingService pressingService;
  final pressingConstants = PressingConstants();
  late TextEditingController adresseController ;
  late FocusNode adresseFocus;
 



  @override
  void initState() {
    searchTextController = TextEditingController();
    pressingService = getIt<PressingService>();
    adresseController = TextEditingController();
    adresseFocus = FocusNode();
    initList();
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
    final shoppingProvider = Provider.of<ShoppingProvider>(context);
    return Material(
      color: Colors.transparent, // or Colors.white
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          /*
          appBar: MoveguiAppBar(
            title: widget.model.name,
            itemCount: shoppingProvider.itemCount,
          ),
          */
          drawer: MoveGuiMenu(navigatorKey: widget.navigatorKey,),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ImageBanner(),
                  const SizedBox(height: 6),
                  Text(
                    widget.model.name,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 145, 8, 10),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.model.description ?? "No description available.",
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
              
                  SizedBox(height: 6),
              
                  PressingPriceList(),
              
                  SizedBox(height: 6),
              
                  Container(
                    color: AppColors.backgroundColor,
                    child: CustomTextField(
                      controller: adresseController,
                      labelText: pressingConstants.getAdressLabeltext(),
                      hintText: pressingConstants.getCustomerAdressHinterText(),
                      inputType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
                      // nextFocusNode: emailFocus,
                      validator: MyValidators.textValidator,
                      icon: Icons.home,
                      hasIcon: true,
                      isNumber: false,
                    ),
                  ),
              
                  SizedBox(height: 10),
              
                  Text("Attention: Prix confirmé par SMS avant lavage !!!", style: TextStyle(color: Colors.red),),
                  Text("Le prix final peut varier selon l’état des vêtements.Le lavage commence après confirmation par SMS.", style: TextStyle(color: Colors.red),),
                  

                    SizedBox(height: 6),
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(12.0),
                          backgroundColor: AppColors.backgroundColor,
                          // backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        icon: const Icon(
                          IconlyLight.send,
                          color: AppColors.textColor,
                        ),
                        label: const Text(
                          "Valider",
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 22,
                          ),
                        ),
                        onPressed: () async {},
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(12.0),
                          backgroundColor: AppColors.backgroundColor,
                          // backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        icon: const Icon(
                          IconlyLight.call,
                          color: AppColors.textColor,
                        ),
                        label: const Text(
                          "Appeler",
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 22,
                          ),
                        ),
                        onPressed: () async {},
                      ),
                    ],
                  ),
              
                  /*
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(widget.model.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  */
                  const SizedBox(height: 15),
              
                  /*
                Expanded(
                  child: DynamicHeightGridView(
                    itemCount: pressings.length,
                    crossAxisCount: 1,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    builder: (context, index) {
                      return StoreWidget(model: pressings[index], catgory: AppConstants.CATEGORY_PRESSING,);
                    },
                  ),
                ),
                */
                ],
              ),
            ),
          ),
          /*
        bottomNavigationBar:RootBottomNavigationBar(
        currentIndex: 1,
        onDestinationSelected: (index) {
          Navigator.pop(context, index);
        },
      ),
      */
        ),
      ),
    );
  }
}
