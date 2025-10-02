import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/validator.dart';
import 'package:movegui/screens/auth/login_screen.dart';
import 'package:movegui/screens/command_screen.dart';
import 'package:movegui/screens/develivery_screen.dart';
import 'package:movegui/screens/home_screen.dart';
import 'package:movegui/screens/reservation_screen.dart';
import 'package:movegui/screens/search_screen.dart';
import 'package:movegui/services/my_app_functions.dart';
import 'package:movegui/widgets/app/appbar.dart';
import 'package:movegui/widgets/auth/image_picker_widget.dart';
import 'package:movegui/widgets/menu/menu.dart';


class RegisterScreenMovgui extends StatefulWidget {
  static const routName = "register";
  const RegisterScreenMovgui({super.key});

  @override
  State<RegisterScreenMovgui> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreenMovgui> {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController controller;
  late Widget _scaffoldBody;
  int currentLoginScreen = 0;

  bool showFirst = true;
  XFile? _pickedImage;

  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreen(title: 'Home'),
      ReservationScreen(title: 'Reservation'),
      Commandscreen(title: 'Commande'),
      DeveliveryScreen(title: 'Livraison'),
    ];
    controller = PageController();
    _scaffoldBody = RegisterPage();
  }

  Future<void> localImagePicker() async {
    final ImagePicker imagePicker = ImagePicker();
    await MyAppFunctions.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        _pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
        setState(() {});
      },
      galleryFCT: () async {
        _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
        setState(() {});
      },
      removeFCT: () {
        setState(() {
          _pickedImage = null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          print("je suis la dans ");
        });
      },
      child: Scaffold(
        appBar: MoveguiAppBar(title: 'Enregistrement'),
        drawer: MoveGuiMenu(),

        //     body: _scaffoldBody,
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // AppImage(),
                SizedBox(
                  height: size.width * 0.3,
                  width: size.width * 0.3,
                  child: PickImageWidget(
                    pickedImage: _pickedImage,
                    function: () async {
                      //    await localImagePicker();
                    },
                  ),
                ),
                RegisterPage(),
                //  LoginPhoneNumberPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  bool obscureText = true;
  late final TextEditingController _nameController,
      _emailController,
      _passwordController,
      _repeatPasswordController;

  late final FocusNode _nameFocusNode,
      _emailFocusNode,
      _passwordFocusNode,
      _repeatPasswordFocusNode;

  final _formkey = GlobalKey<FormState>();
  bool isloading = false;
  FirebaseAuth? auth;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
    // Focus Nodes
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _repeatPasswordFocusNode = FocusNode();
    try {
      auth = FirebaseAuth.instance;
    } catch (e) {
      print('FirebaseAuth initialization failed: $e');
    }
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _nameController.dispose();
      _emailController.dispose();
      _passwordController.dispose();
      _repeatPasswordController.dispose();
      // Focus Nodes
      _nameFocusNode.dispose();
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
      _repeatPasswordFocusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _registerFCT() async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    
    if(isValid){
      try{
        setState(() {
          isloading = true;
        });
       await auth?.createUserWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
       Fluttertoast.showToast(
        msg: "An account has be created",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.pushReplacement(context, 
          MaterialPageRoute(builder: (context) => HomeScreen(title: 'Movegui')));
      }catch(error){
        MyAppFunctions.showErrorOrWarningDialog(
          context: context,
          subtitle: error.toString(),
          fct: (){});
      }finally{
        isloading = false;
      }
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _nameController,
            focusNode: _nameFocusNode,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              hintText: 'Nom',
              prefixIcon: Icon(Icons.person),
            ),
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(_emailFocusNode);
            },
            validator: (value) {
              return MyValidators.displayNamevalidator(value);
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Addresse Email",
              prefixIcon: Icon(IconlyLight.message),
            ),
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            validator: (value) {
              return MyValidators.emailValidator(value);
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.visiblePassword,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: "***********",
              prefixIcon: const Icon(IconlyLight.lock),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            onFieldSubmitted: (value) async {
              FocusScope.of(context).requestFocus(_repeatPasswordFocusNode);
            },
            validator: (value) {
              return MyValidators.passwordValidator(value);
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _repeatPasswordController,
            focusNode: _repeatPasswordFocusNode,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.visiblePassword,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: "Repeter Mot de pass",
              prefixIcon: const Icon(IconlyLight.lock),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            onFieldSubmitted: (value) async {
              await _registerFCT();
            },
            validator: (value) {
              return MyValidators.repeatPasswordValidator(
                value: value,
                password: _passwordController.text,
              );
            },
          ),
          const SizedBox(height: 36.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12.0),
                backgroundColor: AppColors.backgroundColor,
                // backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              icon: const Icon(IconlyLight.addUser, color: AppColors.textColor),
              label: const Text(
                "Enregister",
                style: TextStyle(color: AppColors.textColor, fontSize: 18),
              ),
              onPressed: () async {
                  await _registerFCT();
                print('ich bin da !!!!!!!!!!');
              },
            ),
          ),
        ],
      ),
    );
  }
}
