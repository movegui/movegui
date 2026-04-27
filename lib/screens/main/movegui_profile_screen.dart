import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/person_model.dart';
import 'package:movegui/models/user_model.dart';
import 'package:movegui/providers/login_mod_provider.dart';
import 'package:movegui/screens/auth/login_screen.dart';
import 'package:movegui/services/image_service.dart';
import 'package:movegui/services/my_app_functions.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/services/user_service.dart';
import 'package:movegui/widgets/auth/movegui_full_profile_widget.dart';
import 'package:movegui/widgets/auth/movegui_header_un_full_widget.dart';
import 'package:movegui/widgets/util/profile_menu_title.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class MoveguiProfileScreen extends StatefulWidget {
  const MoveguiProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => MoveguiProfileScreenState();
}

class MoveguiProfileScreenState extends State<MoveguiProfileScreen> {
  FirebaseAuth? auth;
  File? pickedImage;
  Uint8List? webImage;
  late String gender;
  late DateTime birthdate;
  late UserModel? currentUser;
  late UserService userService;
  late ImageService imageService;
  late TextEditingController nameController;
  late FocusNode nameFocusNode;
  XFile? _pickedImage;
  late bool isNew;
  late int loginMode = -1;

  Future<void> onNameUpdate(String? value) async {
    setState(() async {
      nameController.text = value!;
      if (value != null && !value.isEmpty) {
        UserModel updatedUser = UserModel(
          updatedAt: DateTime.now(),
          id: currentUser!.id,
          name: nameController.text,
          createdAt: currentUser!.createdAt,
          username: currentUser!.username,
          personModel: currentUser!.personModel,
        );
        await userService.update(updatedUser);
        setState(() {
          currentUser = updatedUser;
        });
      }
    });
  }

  Future<void> localImagePicker() async {
    final ImagePicker imagePicker = ImagePicker();
    await MyAppFunctions.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        final XFile? file = await imagePicker.pickImage(
          source: ImageSource.camera,
        );
        if (file == null) return;
        final bytes = await file.readAsBytes();
        await updloadImage(bytes);
        setState(() {
          webImage = bytes;
        });
      },
      galleryFCT: () async {
        final XFile? file = await imagePicker.pickImage(
          source: ImageSource.gallery,
        );
        if (file == null) return;
        final bytes = await file.readAsBytes();
        await updloadImage(bytes);
        setState(() {
          webImage = bytes;
        });
      },
      removeFCT: () {
        setState(() {
          webImage = null;
          pickedImage = null;
        });
      },
    );
  }

  Future<void> updloadImage(Uint8List? bytes) async {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        String? url = await imageService.uploadImage(
          file: null,
          webBytes: bytes,
          collectionName: userService.getCollectionName(),
        );
        if (url != null) {
          UserModel updatedUser = UserModel(
            updatedAt: DateTime.now(),
            id: currentUser!.id,
            name: currentUser!.name,
            createdAt: currentUser!.createdAt,
            username: currentUser!.username,

            personModel: PersonModel(
              id: currentUser!.personModel!.id,
              name: currentUser!.name,
              createdAt: DateTime.now(),
              firstName: currentUser!.name,
              lastName: currentUser!.personModel!.lastName,
              profileImageUrl: url,
              email: currentUser!.personModel!.email,
              phone: currentUser!.personModel!.phone,
              gender: currentUser!.personModel!.gender,
              birthDate: currentUser!.personModel!.birthDate,
              addresses: currentUser!.personModel!.addresses,
            ),
          );

          if (isNew)
            await userService.addModel(updatedUser);
          else
            await userService.update(updatedUser);
          isNew = false;
          setState(() {
            currentUser = updatedUser;
          });
        }
      }
    });
  }

  @override
  void initState() {
    userService = getIt<UserService>();
    imageService = getIt<ImageService>();
    auth = FirebaseAuth.instance;
    currentUser = null;
    nameController = TextEditingController();
    nameFocusNode = FocusNode();
    isNew = false;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initialize();
    });
  }

  Future<void> _initialize() async {
    loginMode = context.read<LoginModProvider>().loginMode;

    if (auth?.currentUser != null) {
      if (auth?.currentUser?.email != null) {
        if (loginMode != AppConstants.LONGIN_EMAIL_MODE) {
          loginMode = AppConstants.LONGIN_EMAIL_MODE;
          context.read<LoginModProvider>().setLoginMod(loginMode);
        }
        currentUser = await userService.getByEmail(
          auth?.currentUser?.email ?? '',
        );
      } else if (auth?.currentUser?.phoneNumber != null) {
        if (loginMode != AppConstants.LOGIN_PHONE_MODE) {
          loginMode = AppConstants.LOGIN_PHONE_MODE;
          context.read<LoginModProvider>().setLoginMod(loginMode);
        }
        currentUser = await userService.getByPhone(
          auth?.currentUser?.phoneNumber ?? '',
        );
      }
      if (currentUser == null) {
        isNew = true;
        setState(() {
          currentUser = UserModel(
            updatedAt: DateTime.now(),
            id: auth?.currentUser?.uid ?? '',
            name: auth?.currentUser?.displayName ?? '',
            createdAt: DateTime.now(),
            username:
                loginMode == AppConstants.LONGIN_EMAIL_MODE
                    ? auth?.currentUser?.email
                    : loginMode == AppConstants.LOGIN_PHONE_MODE
                    ? auth?.currentUser?.phoneNumber
                    : null,
            personModel: PersonModel(
              id: Uuid().v4(),
              name: auth?.currentUser?.displayName ?? '',
              createdAt: DateTime.now(),
              firstName: '',
              lastName: auth?.currentUser?.displayName ?? '',
              profileImageUrl: null,
              email:
                  loginMode == AppConstants.LONGIN_EMAIL_MODE
                      ? auth?.currentUser?.email
                      : null,
              phone:
                  loginMode == AppConstants.LOGIN_PHONE_MODE
                      ? auth?.currentUser?.phoneNumber
                      : null,
              gender: '',
              birthDate: null,
              addresses: [],
            ),
          );
        });
      }
    }
  }

  void chekLoginMode() {
    if (FirebaseAuth.instance.currentUser?.email != null) {
      context.read<LoginModProvider>().setLoginMod(
        AppConstants.LONGIN_EMAIL_MODE,
      );
    } else if (FirebaseAuth.instance.currentUser?.phoneNumber != null) {
      context.read<LoginModProvider>().setLoginMod(
        AppConstants.LOGIN_PHONE_MODE,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //     chekLoginMode();
          return Scaffold(
            backgroundColor: AppColors.textColor,
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(
                  WidgetConstants.sepWidgetHeight * 2,
                ),
                children: [
                  currentUser?.name == null ||
                          currentUser?.personModel?.profileImageUrl == null
                      ? unFullHeaderProfile()
                      : fullProfile(),
                  const SizedBox(height: WidgetConstants.sepWidgetHeight * 2),
                  _buildFirstSection(),
                  const SizedBox(height: WidgetConstants.sepWidgetHeight * 2),
                  _buildSecondSection(),
                  const SizedBox(height: WidgetConstants.sepWidgetHeight * 2),
                  _buildThirdSection(),
                ],
              ),
            ),
          );
        } else {
          return LoginScreen();
        }
      },
    );
  }

  Widget _buildFirstSection() {
    return _sectionCard([
      currentUser != null
          ? ProfileMenuTitle(
            icon: Icons.logout,
            title: AppLocalizations.of(context)!.profile_menu_logout,
            onTap: () async => {await userService.signOut()},
          )
          : ProfileMenuTitle(
            icon: Icons.logout,
            title: AppLocalizations.of(context)!.profile_menu_logout,
          ),

      ProfileMenuTitle(
        icon: Icons.person_add,
        title: AppLocalizations.of(context)!.profile_menu_invite_people,
      ),
      ProfileMenuTitle(
        icon: Icons.list,
        title: AppLocalizations.of(context)!.profile_menu_orders,
      ),
      ProfileMenuTitle(
        icon: Icons.campaign,
        title: AppLocalizations.of(context)!.profile_menu_message,
      ),
      ProfileMenuTitle(
        icon: Icons.star_border,
        title: AppLocalizations.of(context)!.profile_menu_important,
      ),
      ProfileMenuTitle(
        icon: Icons.devices,
        title: AppLocalizations.of(context)!.profile_menu_devices,
      ),
    ]);
  }

  Widget _buildSecondSection() {
    return _sectionCard([
      ProfileMenuTitle(
        icon: Icons.key,
        title: AppLocalizations.of(context)!.profile_menu_account,
      ),
      ProfileMenuTitle(
        icon: Icons.lock_outline,
        title: AppLocalizations.of(context)!.profile_menu_confidentiality,
      ),
      ProfileMenuTitle(
        icon: Icons.chat_bubble_outline,
        title: AppLocalizations.of(context)!.profile_menu_discussions,
      ),
      ProfileMenuTitle(
        icon: Icons.notifications_none,
        title: AppLocalizations.of(context)!.profile_menu_notification,
      ),
    ]);
  }

  Widget _buildThirdSection() {
    return _sectionCard([
      ProfileMenuTitle(
        icon: Icons.key,
        title: AppLocalizations.of(context)!.profile_menu_delete_account,
      ),
    ]);
  }

  Widget _sectionCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: List.generate(
          children.length,
          (index) => Column(
            children: [
              children[index],
              if (index != children.length - 1)
                const Divider(height: 1, indent: 56),
            ],
          ),
        ),
      ),
    );
  }

  Widget fullProfile() {
    return MoveguiFullProfileWidget();
  }

  Widget unFullHeaderProfile() {
    return MoveguiHeaderUnFullWidget(
      onNameUpdate: (value) async {
        onNameUpdate(value);
      },
      onPickImage: () async {
        localImagePicker();
      },
      currentUser: currentUser,
      nameController: nameController,
      nameFocusNode: nameFocusNode,
      pickedImage: pickedImage,
      webImage: webImage,
    );
  }
}
