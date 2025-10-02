import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:movegui/screens/auth/login_screen.dart';
import 'package:movegui/screens/home_screen.dart';
import 'package:movegui/screens/search_screen.dart';
import 'package:movegui/widgets/app/appbar.dart';
import 'package:movegui/widgets/menu/menu.dart';
import 'package:movegui/widgets/products/product_widget.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:movegui/widgets/title_text.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<ProductScreen> {
  late TextEditingController searchTextController;


  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
             appBar: MoveguiAppBar(title: 'Search Products'),
        drawer: MoveGuiMenu(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: searchTextController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      // setState(() {
                      FocusScope.of(context).unfocus();
                      searchTextController.clear();
                      // });
                    },
                    child: const Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
                  ),
                ),
                onChanged: (value) {
                  log("value of the text is $value");
                },
                onSubmitted: (value) {
                  // log("value of the text is $value");
                  // log("value of the controller text: ${searchTextController.text}");
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
              Expanded(
                child: DynamicHeightGridView(
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    builder: (context, index) {
                      return const ProductWidget();
                    },
                    itemCount: 200,
                    crossAxisCount: 2),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
        height: 100,
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 130,
                child: Column(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitlesTextWidget(
                      label: "Addresse:",
                      color: Theme.of(context).secondaryHeaderColor,
                      decoration: TextDecoration.underline,
                    ),
                    Text(
                      'Kobaya commune de ratoma Conakry',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 140,
                child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitlesTextWidget(
                      label: "E-Mail:",
                      color: Theme.of(context).secondaryHeaderColor,
                      decoration: TextDecoration.underline,
                    ),
                    Text('movegui@gmail.com', 
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                child: Column(
                  //              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                           TitlesTextWidget(
                      label: "Telephone",
                      color: Theme.of(context).secondaryHeaderColor,
                      decoration: TextDecoration.underline,
                    ),
                    Text('623-259-584', 
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
