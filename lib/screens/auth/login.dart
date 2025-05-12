import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/validator.dart';
import 'package:movegui/screens/command_screen.dart';
import 'package:movegui/screens/develivery_screen.dart';
import 'package:movegui/screens/home_screen.dart';
import 'package:movegui/screens/reservation_screen.dart';
import 'package:movegui/screens/search_screen.dart';
import 'package:movegui/services/assets_manager.dart';
import 'package:movegui/widgets/app_image.dart';
import 'package:movegui/widgets/app_name_text.dart';
import 'package:movegui/widgets/auth/google_btn.dart';
import 'package:movegui/widgets/menu.dart';
import 'package:movegui/widgets/subtitle_text.dart';
import 'package:movegui/widgets/title_text.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  
  late List<Widget> screens;
   int currentScreen = 0;
  late PageController controller;
  late Widget _scaffoldBody;

  @override
  void initState() {
    super.initState();
        screens = [
      HomeScreen(title: 'Home'),
      ReservationScreen(title: 'Reservation'),
      Commandscreen(title: 'Commande',),
      DeveliveryScreen(title: 'Livraison',),
    ];
      controller = PageController();
    _scaffoldBody = LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
         appBar: AppBar(
        title: Text(' '),
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
                      builder: (context) => SearchScreen()));
                       
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            color: Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(title: 'Notification',)));
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            color: Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
        drawer: MoveGuiMenu(),
        body: _scaffoldBody,
              bottomNavigationBar: 
      NavigationBarTheme(data: NavigationBarThemeData(
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
      if (states.contains(WidgetState.selected)) {
        return const TextStyle(
          color: AppColors.secondary,
          fontWeight: FontWeight.bold,
        );
      }
      return const TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.normal,
      );
    }),
  ),
       child: 
      NavigationBar(
        indicatorColor: Colors.transparent,
        selectedIndex: currentScreen,
         backgroundColor: Theme.of(context).primaryColor,
        elevation: 10,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (index) {
          setState(() {
            currentScreen = index;
            _scaffoldBody = PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: screens,
      );
          });
          controller.jumpToPage(currentScreen);
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: AppColors.secondary,),
            icon: Icon(Icons.home, color: AppColors.white,),
            label: "Home",
          ),
          NavigationDestination(
            selectedIcon: ImageIcon(AssetImage(AssetsManager.reservationIcon3), color: AppColors.secondary,),
            icon: ImageIcon(AssetImage(AssetsManager.reservationIcon3), color: AppColors.white, size: 24, ),
            label: "Reservation",
           
          ),
          NavigationDestination(
            selectedIcon: ImageIcon(AssetImage(AssetsManager.commandeIcon3), color: AppColors.secondary, size: 24,),
            icon: ImageIcon(AssetImage(AssetsManager.commandeIcon3), color: AppColors.white,),
            label: "Commande",
          ),
          NavigationDestination(
            selectedIcon: ImageIcon(AssetImage(AssetsManager.livraisonIcon3), color: AppColors.secondary,),
            icon: ImageIcon(AssetImage(AssetsManager.livraisonIcon3), color: AppColors.white,),
            label: "Livraison",
          ),
        ],
      ),
    )
      ),
    );
  }
}

class LoginPage extends StatefulWidget {

  
  @override
  State<StatefulWidget> createState() => LoginPageState();
  
}

class LoginPageState extends State<LoginPage>{

    late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  final _formkey = GlobalKey<FormState>();
  bool obscureText = true;
  bool _isHoveringForgetText = false;
  bool _isHoveringRegisterText = false;

    @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    // Focus Nodes
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
      _passwordController.dispose();
      // Focus Nodes
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
    }
    super.dispose();
  }

    Future<void> _loginFct() async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /*
                const AppNameTextWidget(
                  fontSize: 40,
                ),
                */
                AppImage(),

                /*
                const Align(
                    alignment: Alignment.centerLeft,
                    child: TitlesTextWidget(label: "Welcome back!")),
                const SizedBox(
                  height: 16,
                ),
                */
                Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Email address",
                          prefixIcon: Icon(
                            IconlyLight.message,
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
                        },
                        validator: (value) {
                          return MyValidators.emailValidator(value);
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        obscureText: obscureText,
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          hintText: "***********",
                          prefixIcon: const Icon(
                            IconlyLight.lock,
                          ),
                        ),
                        onFieldSubmitted: (value) async {
                          await _loginFct();
                        },
                        validator: (value) {
                          return MyValidators.passwordValidator(value);
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: MouseRegion(
                          onEnter: (_) => setState(() => _isHoveringForgetText = true),
                          onExit: (_) => setState(() => _isHoveringForgetText = false),
                          child: TextButton(
                            onPressed: () {},
                            child:  SubtitleTextWidget(
                              label: "Mot de pass oublier?",
                              fontStyle: FontStyle.italic,
                              textDecoration: TextDecoration.underline,
                              color:  _isHoveringForgetText ? AppColors.secondary : AppColors.primary,
                              
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(6.0),
                             backgroundColor: AppColors.primary,
                  
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                6.0,
                              ),
                            ),
                      
   
                          ),
                          icon: const Icon(Icons.login, color: AppColors.white),
                          label: const Text("Login", style: TextStyle(color: AppColors.white, fontSize: 18),),
                          onPressed: () async {
                            await _loginFct();
                          },
                          
                        ),
                      ),
                      
                      const SizedBox(
                        height: 16.0,
                      ),
                      
                      SubtitleTextWidget(
                        label: "Or connect using".toUpperCase(),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      SizedBox(
                   //     height: kBottomNavigationBarHeight + 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
            
                          children: [
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: FittedBox(
                                    child: GoogleButton(),
                                  ),
                             ),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(6.0),
                                       backgroundColor: AppColors.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          12.0,
                                        ),
                                      ),
                                    ),
                                    child: const Text("Invite ?", style: TextStyle(color: AppColors.white, fontSize: 14),),
                                    onPressed: () async {},
                                                                   ),
                                 )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SubtitleTextWidget(label: "Nouveau ?"),
                          MouseRegion(
                            onEnter: (_) => setState(() => _isHoveringRegisterText = true),
                            onExit: (_) => setState(() => _isHoveringRegisterText = false),
                            child: TextButton(
                              child:  SubtitleTextWidget(
                                label: "Enregistrement",
                                fontStyle: FontStyle.italic,
                                textDecoration: TextDecoration.underline,
                                color: _isHoveringRegisterText ? AppColors.secondary : AppColors.primary,
                              ),
                              onPressed: () {
                                /*
                                Navigator.of(context)
                                    .pushNamed(RegisterScreen.routName);
                                    */
                              },
                            ),
                          ),
                        ],
                      )
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
