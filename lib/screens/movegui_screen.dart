import 'package:flutter/material.dart';
import 'package:movegui/screens/home_screen.dart';
import 'package:movegui/services/assets_manager.dart';
import 'package:movegui/services/title_manager.dart';
import 'package:movegui/widgets/menu.dart';
import 'package:movegui/widgets/title_text.dart';

class MoveguiScreen extends StatelessWidget {
  const MoveguiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TitleManager.moveguiTitle),
        titleTextStyle: TextStyle(
          color: Color(0xFFFFFFFF), // Set the title color
          fontSize: 20,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              color: Color(0xFFFFFFFF),
              tooltip: 'Navigation menu',
              onPressed: () {
                //  _showMenu(context);
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        backgroundColor: Color(0xFF871A1C), // Customize color
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(title: 'Search'),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            color: Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(title: 'Notification'),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            color: Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(title: 'User'),
                ),
              );
            },
          ),
        ],
      ),
      drawer: MoveGuiMenu(),
      body: BodyWidget(),
    );
  }
}

class BodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            SizedBox(width: 8,),
            Column(
              children: [
                       TitlesTextWidget(
                      label: "Description",
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                    Text('ici le text de description ........................', 
                    textAlign: TextAlign.center,
                    ),
                    Text('ici le text de description ........................', 
                    textAlign: TextAlign.center,
                    ),
                    Text('ici le text de description ........................', 
                    textAlign: TextAlign.center,
                    ),
              ],
            ),
              Column(
              children: [
                       TitlesTextWidget(
                      label: "Reklamation",
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                    Text('ici le text de reklamation ........................', 
                    textAlign: TextAlign.center,
                    ),
                    Text('ici le text de reklamation ........................', 
                    textAlign: TextAlign.center,
                    ),
                    Text('ici le text de reklamation ........................', 
                    textAlign: TextAlign.center,
                    ),
              ],
            ),
              Column(
              children: [
                       TitlesTextWidget(
                      label: "Suggestion",
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                    Text('ici le text de suggestion ........................', 
                    textAlign: TextAlign.center,
                    ),
                    Text('ici le text de suggestion ........................', 
                    textAlign: TextAlign.center,
                    ),
                    Text('ici le text de suggestion ........................', 
                    textAlign: TextAlign.center,
                    ),
              ],
            ),
                Column(
              children: [
                       TitlesTextWidget(
                      label: "Contatct",
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                    Text('ici le text de contact ........................', 
                    textAlign: TextAlign.center,
                    ),
                    Text('ici le text de contact ........................', 
                    textAlign: TextAlign.center,
                    ),
                    Text('ici le text de contact ........................', 
                    textAlign: TextAlign.center,
                    ),
              ],
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
    );
  }
}
