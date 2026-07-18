import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/models/user_model.dart';
import 'package:movegui/providers/auth_provider.dart';
import 'package:movegui/providers/providers.dart';
import 'package:movegui/screens/auth/login_screen.dart';
import 'package:movegui/services/form_services/adress_form_service.dart';
import 'package:movegui/services/image_service.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/services/user_service.dart';
import 'package:movegui/widgets/address/add_adress_widget.dart';
import 'package:movegui/widgets/error/message_widget.dart';
import 'package:movegui/widgets/formsControllers/address_form_controller.dart';
import 'package:movegui/widgets/util/btn_register_cancel_widget.dart';
import 'package:movegui/widgets/util/profile_menu_title.dart';

class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({super.key, required this.id});
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AccountScreenState();
}

class AccountScreenState extends ConsumerState<AccountScreen> {
  FirebaseAuth? auth;
  late UserModel? currentUser;
  late UserService userService;
  late ImageService imageService;
  late TextEditingController controller;
  late List<AddressFormController> addressesForms = [];
  late AdressFormService adressFormService;
  final addAddressKey = GlobalKey<AddAdressWidgetState>();
  bool adressesHasChanged = false;

  @override
  void initState() {
    controller = TextEditingController();
    addressesForms = [];
    userService = getIt<UserService>();
    imageService = getIt<ImageService>();
    adressFormService = getIt<AdressFormService>();
    auth = FirebaseAuth.instance;
    currentUser = null;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initialize();
    });
  }

  Future<void> _initialize() async {
    currentUser = ref.read(userProviderState).user;
    if (currentUser == null) {
      currentUser = await userService.getById(widget.id);
      if (currentUser != null) {
        ref.read(userProviderState).setUser(currentUser!);
      } else {
        MessageWidget.errorMessage(
          context,
          AppLocalizations.of(context)!.error_user_not_found_title,
          AppLocalizations.of(context)!.error_user_not_found_message,
          Icon(Icons.error, color: AppColors.error),
          FlushbarPosition.TOP,
        );
        await userService.signOut();
      }
    }
  }

  void navigateToRoute(String route) {
    context.push(route);
  }

  Future<void> _registerNameFCT(BuildContext context, ButtonItem item) async {
    if (!item.enabled) {
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.deactivate_button_title,
        AppLocalizations.of(context)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    } else {
      if (controller.text.trim() == currentUser?.name) return;
      final updatedUser = await userService.updateUsername(
        controller.text.trim(),
        currentUser!,
      );
      if (updatedUser != null) {
        setState(() {
          currentUser = updatedUser;
          ref.read(userProviderState).setUser(currentUser!);
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.success_username_updated,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        });
      } else {
        MessageWidget.errorMessage(
          context,
          AppLocalizations.of(context)!.error_send_mail_title,
          AppLocalizations.of(context)!.error_send_mail_message,
          Icon(Icons.error, color: AppColors.error),
          FlushbarPosition.TOP,
        );
      }
    }
    Navigator.pop(context);
  }

  Future<void> _registerEmailFCT(BuildContext context, ButtonItem item) async {
    if (!item.enabled) {
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.deactivate_button_title,
        AppLocalizations.of(context)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    } else {
      if (controller.text.trim() == currentUser?.personModel?.email) return;
      final updatedUser = await userService.updateUserEmail(
        controller.text.trim(),
        currentUser!,
      );
      if (updatedUser != null) {
        setState(() {
          currentUser = updatedUser;
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.success_login_message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        });
      } else {
        MessageWidget.errorMessage(
          context,
          AppLocalizations.of(context)!.error_send_mail_title,
          AppLocalizations.of(context)!.error_send_mail_message,
          Icon(Icons.error, color: AppColors.error),
          FlushbarPosition.TOP,
        );
      }
    }
    Navigator.pop(context);
  }

  Future<void> _registerPhoneFCT(BuildContext context, ButtonItem item) async {
    if (!item.enabled) {
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.deactivate_button_title,
        AppLocalizations.of(context)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    } else {
      if (controller.text.trim() == currentUser?.personModel?.email) return;
      final updatedUser = await userService.updateUserPhone(
        controller.text.trim(),
        currentUser!,
      );
      if (updatedUser != null) {
        setState(() {
          currentUser = updatedUser;
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.success_login_message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        });
      } else {
        MessageWidget.errorMessage(
          context,
          AppLocalizations.of(context)!.error_send_mail_title,
          AppLocalizations.of(context)!.error_send_mail_message,
          Icon(Icons.error, color: AppColors.error),
          FlushbarPosition.TOP,
        );
      }
    }
    Navigator.pop(context);
  }

  Future<void> _registerAdressesFct(
    BuildContext context,
    ButtonItem item,
  ) async {
    if (!item.enabled) {
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.deactivate_button_title,
        AppLocalizations.of(context)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    } else {
      if (adressesHasChanged) {
        final newAdresses = await addAddressKey.currentState?.getAddresses();
        if (newAdresses != null && newAdresses.isNotEmpty) {
          if (currentUser != null) {
            currentUser?.personModel?.addresses = newAdresses;
            await userService.update(currentUser!);
            _cancelFct(context, item);
          }
        }
      }
    }
  }

  Future<void> _cancelFct(BuildContext context, ButtonItem item) async {
    if (!item.enabled) {
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.deactivate_button_title,
        AppLocalizations.of(context)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    } else {
      Navigator.pop(context);
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
                  Text(
                    AppLocalizations.of(context)!.account_title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: WidgetConstants.sepWidgetHeight),
                  _buildFirstSection(),
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
      ProfileMenuTitle(
        icon: Icons.account_circle,
        title: AppLocalizations.of(context)!.account_info,
        onTap: () => notImplemented(),
        enabled: false,
      ),
      ProfileMenuTitle(
        icon: Icons.person,
        title: AppLocalizations.of(context)!.account_edit_name,
        onTap: () => changeProfileName(),
        enabled: true,
      ),
      ProfileMenuTitle(
        icon: Icons.email,
        title: AppLocalizations.of(context)!.account_edit_email,
        onTap: () => notImplemented(),
        enabled: false,
      ),
      ProfileMenuTitle(
        icon: Icons.phone,
        title: AppLocalizations.of(context)!.account_edit_phone,
        onTap: () => notImplemented(),
        enabled: false,
      ),
      ProfileMenuTitle(
        icon: Icons.location_on,
        title: AppLocalizations.of(context)!.account_adresse,
        onTap: () => UpdateAddresses(),
        enabled: true,
      ),
      ProfileMenuTitle(
        icon: Icons.delete,
        title: AppLocalizations.of(context)!.profile_menu_delete_account,
        onTap: () => notImplemented(),
        enabled: false,
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

  Future<dynamic> notImplemented() {
    return MessageWidget.errorMessage(
      context,
      AppLocalizations.of(context)!.deactivate_button_title,
      AppLocalizations.of(context)!.deactivate_button_message,
      Icon(Icons.error, color: AppColors.error),
      FlushbarPosition.TOP,
    );
  }

  Future<void> changeProfileName() async {
    controller.text = currentUser?.name ?? '';
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.account_edit_name),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText:
                    AppLocalizations.of(context)!.account_edit_name_new_name,
              ),
            ),
            actions: [
              BtnRegisterCancelWidget(
                registerFCT: _registerNameFCT,
                cancelFCT: _cancelFct,
              ),
            ],
          ),
    );
  }

  Future<void> changeEmail() async {
    controller.text = currentUser?.personModel?.email ?? '';
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.account_edit_email),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText:
                    AppLocalizations.of(context)!.account_edit_email_new_email,
              ),
            ),
            actions: [
              BtnRegisterCancelWidget(
                registerFCT: _registerEmailFCT,
                cancelFCT: _cancelFct,
              ),
            ],
          ),
    );
  }

  Future<void> changePhone() async {
    controller.text = currentUser?.personModel?.phone ?? '';
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.account_edit_phone),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText:
                    AppLocalizations.of(context)!.account_edit_phone_new_phone,
              ),
            ),
            actions: [
              BtnRegisterCancelWidget(
                registerFCT: _registerPhoneFCT,
                cancelFCT: _cancelFct,
              ),
            ],
          ),
    );
  }

  Future<void> UpdateAddresses() async {
    if (currentUser == null) return;

    final addresses = currentUser!.personModel?.addresses ?? [];

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.account_adresse),

          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: AddAdressWidget(
                key: addAddressKey,
                adresses: addresses,
                registedAdressesCount: addresses.length,
                onCountChange: (bool value) {
                  setState(() {
                    adressesHasChanged = true;
                  });
                },
                user: currentUser!,
                enabledAsStandard: true,
                onAdressTypeChange: (value, index) {
                  if (addresses[index]?.adressType != value) {
                    setState(() {
                      adressesHasChanged = true;
                    });
                  } else {
                    setState(() {
                      adressesHasChanged = false;
                    });
                  }
                },
                onCommuneChange: (value, index) {
                  if (addresses[index]?.minucipality != value) {
                    setState(() {
                      adressesHasChanged = true;
                    });
                  } else {
                    setState(() {
                      adressesHasChanged = false;
                    });
                  }
                },
                onChange: (value) {
                  setState(() {
                    adressesHasChanged = true;
                  });
                },
              ),
            ),
          ),

          actions: [
            BtnRegisterCancelWidget(
              registerFCT: _registerAdressesFct,
              cancelFCT: _cancelFct,
            ),
          ],
        );
      },
    );
  }
}
