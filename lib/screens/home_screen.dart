import 'package:flutter/material.dart';
import 'package:movegui/providers/theme_provider.dart';
import 'package:movegui/screens/movegui_screen.dart';
import 'package:movegui/screens/root_screen.dart';
import 'package:movegui/services/assets_manager.dart';
import 'package:movegui/services/title_manager.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.title});

  final bool isHorizontal = false;
  final String title;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.symmetric(horizontal: 2),
              width: MediaQuery.of(context).size.width, // 70% of screen width
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                image: DecorationImage(
                  image: AssetImage(
                    AssetsManager.moveguiIcon,
                  ), // or NetworkImage
                  fit: BoxFit.fill, // covers entire container

                  /*
                   colorFilter: ColorFilter.mode(
                      Theme.of(context).scaffoldBackgroundColor, // Change this to your desired color and opacity
                      BlendMode.color, // Other modes: overlay, multiply, etc.
                    ),
                    */
                ),
              ),
              // child: Image.asset("assets/icons/movegui.jpg",),
            ),
            SwitchListTile(
              title: Text(
                themeProvider.getIsDarkTheme ? "Dark Mode" : "Light Mode",
              ),
              value: themeProvider.getIsDarkTheme,
              onChanged: (value) {
                themeProvider.setDarkTheme(themeValue: value);
              },
            ),
            HomeItem(),
          ],
        ),
      ),
    );
  }
}

class HomeItem extends StatefulWidget {
  const HomeItem({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeItemState();
  }
}

class HomeItemState extends State<HomeItem> {
  _onPressedImage(BuildContext context, int index, String title) {
    routingWithIndex(context, index, title);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MoveguiWidgetImage(
                  title: TitleManager.moveguiTitle,
                  imagePath: AssetsManager.moveguiIcon,
                  action: (context, index, title) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => MoveguiScreen(),
                      ),
                    );
                  },
                  index: 0,
                ),
                MoveguiWidgetImage(
                  title: TitleManager.courseTitle,
                  imagePath: AssetsManager.courseIcon,
                  action: _onPressedImage,
                  index: 1,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MoveguiWidgetImage(
                  title: TitleManager.commandTitle,
                  imagePath: AssetsManager.commandeIcon,
                  action: _onPressedImage,
                  index: 2,
                ),
                MoveguiWidgetImage(
                  title: TitleManager.livraisonTitle,
                  imagePath: AssetsManager.livraisonIcon,
                  action: _onPressedImage,
                  index: 3,
                ),
              ],
            ),
          ],
        ),
      ),
    );

    /*
        child: Card(
          child: Container(
            padding: EdgeInsets.all(6),
            margin: EdgeInsets.symmetric(horizontal: 2),
            width: MediaQuery.of(context).size.width * 0.33, // 70% of screen width
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage('assets/icons/moveguiB.jpg'), // or NetworkImage
                fit: BoxFit.cover, // covers entire container
              ),
            ),
          ),
        ),
      ),
    );
    */
  }
}

class MoveguiWidgetImage extends StatelessWidget {
  const MoveguiWidgetImage({
    super.key,
    required this.title,
    required this.imagePath,
    required this.action,
    required this.index,
  });
  final String title;
  final String imagePath;
  final int index;
  final Function(BuildContext context, int index, String title) action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: ElevatedButton(
        onPressed: () => action(context, index, title),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(),
          padding: EdgeInsets.all(1),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          //  backgroundColor: Color(0xFF871A1C)
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.42,
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(0),
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                image: DecorationImage(
                  image: AssetImage(imagePath), // or NetworkImage
                  fit: BoxFit.fitHeight, // covers entire container
                  /*
                    colorFilter: ColorFilter.mode(
                      Color(
                          0xFF871A1C), // Change this to your desired color and opacity
                      BlendMode.color, // Other modes: overlay, multiply, etc.
                    ),
                    */
                ),
              ),
            ),
            Container(
              color: Color(0xFF871A1C),
              padding: EdgeInsets.only(top: 2),
              width: MediaQuery.of(context).size.width * 0.42,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      //   backgroundColor: Colors.black)
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void routingWithIndex(BuildContext context, int index, String title) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RootScreen(currentScreen: index, title: title),
    ),
  );
}
