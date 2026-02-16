import 'package:flutter/material.dart';
import 'package:movegui/providers/theme_provider.dart';
import 'package:movegui/services/assets_manager.dart';
import 'package:movegui/services/title_manager.dart';
import 'package:movegui/widgets/home/home_page_content_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {


  
  const HomeScreen({
    super.key,
    required this.onTitleChange,
    required this.navigatorKey,
    required this.routeObserver,
  });
  final Function(String) onTitleChange;
  final GlobalKey<NavigatorState> navigatorKey;
  final bool isHorizontal = false;
  final RouteObserver<ModalRoute<void>> routeObserver;


  
  @override
  State<StatefulWidget> createState()  => HomescreenState();
}

class HomescreenState extends State<HomeScreen> with RouteAware{

  @override
  void initState() {
    super.initState();
            WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTitleChange(TitleManager.homeTitle);
    });
  }


    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    widget.routeObserver.unsubscribe(this);
    super.dispose();
  }

  // Called when this screen is visible again (after popping back)
  @override
  void didPopNext() {
    print('im there');
    widget.onTitleChange(TitleManager.homeTitle);
  }

   @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          width:
                              MediaQuery.of(
                                context,
                              ).size.width, // 70% of screen width
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
                        ),
                        SwitchListTile(
                          title: Text(
                            themeProvider.getIsDarkTheme
                                ? "Dark Mode"
                                : "Light Mode",
                          ),
                          value: themeProvider.getIsDarkTheme,
                          onChanged: (value) {
                            themeProvider.setDarkTheme(themeValue: value);
                          },
                        ),
                        HomePageContentWidget(navigatorKey: widget.navigatorKey,),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
