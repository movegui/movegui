import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/providers/appbar_title_provider.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/services/my_app_functions.dart';
import 'package:movegui/widgets/app/app_image.dart';
import 'package:movegui/widgets/auth/register_email_page.dart';
import 'package:movegui/widgets/auth/register_phone_page.dart';
import 'package:movegui/widgets/util/toogle_buttons.dart';
import 'package:provider/provider.dart';

class MoveguiRegisterScreen extends StatefulWidget {
  const MoveguiRegisterScreen({super.key, });

  @override
  State<MoveguiRegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<MoveguiRegisterScreen> {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController controller;
  int currentLoginScreen = 0;

  bool showFirst = true;
  XFile? _pickedImage;
  late String gender;
  late DateTime birthdate;

  @override
  void initState() {
    super.initState();
  }

  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppbarTitleProvider>().setTitle(
        AppLocalizations.of(context)!.register_title,
      );
    });
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

  void updateState(int state) {
    setState(() {
      currentLoginScreen = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {});
      },
      child: Scaffold(
        body: Responsive.isDesktop(context) ? buildDesktop() : buildMobil(),
      ),
    );
  }

  Widget buildMobil() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppImage(),
            ToggleButtonExample(onStateChanged: updateState),
            SizedBox(height: 8),
            currentLoginScreen == 0
                ? RegisterPhonePage(onGenderChanged: (String? value) {})
                : RegisterEmailPage(
                  onGenderChanged: (String? value) {gender = value!;},
                ),
          ],
        ),
      ),
    );
  }

  Widget buildDesktop() {
    return Center(
      child: Container(
        width: 500,
        //   height: 500,
        decoration: BoxDecoration(
          color: AppColors.textColor,
          border: Border.all(color: AppColors.backgroundColor, width: 10),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppImage(),
            ToggleButtonExample(onStateChanged: updateState),
            SizedBox(height: 8),
            currentLoginScreen == 0
                ? RegisterPhonePage(onGenderChanged: (String? value) { gender = value!;})
                : RegisterEmailPage(
                  onGenderChanged: (String? value) { gender = value!;},
                ),
          ],
        ),
      ),
    );
  }
}
