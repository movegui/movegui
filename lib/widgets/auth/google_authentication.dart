import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/route_contants.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/services/user_service.dart';
import 'package:movegui/widgets/error/message_widget.dart';
import 'package:movegui/widgets/util/button_widget.dart';

class GoogleAuthentication extends StatefulWidget {
  const GoogleAuthentication({super.key});

  @override
  State<GoogleAuthentication> createState() => GoogleAuthenticationState();
}

class GoogleAuthenticationState extends State<GoogleAuthentication> {
  bool _isLoading = false;
  late UserService userService;

  @override
  initState() {
    super.initState();
    userService = getIt<UserService>();
  }

  Future<void> _onPressed(BuildContext context, ButtonItem item) async {
    try {
      if (!item.enabled) {
        setState(() => _isLoading = true);
        //  final userService = UserService(api: null); // Update with your API instance
        final user = await userService.registerWithGoogle(context);
        if (user != null) {
          // widget.onLoginSuccess?.call();
          context.go(item.routeName!);
        }
      } else {
        MessageWidget.errorMessage(
          context,
          AppLocalizations.of(context)!.deactivate_button_title,
          AppLocalizations.of(context)!.deactivate_button_message,
          Icon(Icons.error, color: AppColors.error),
          FlushbarPosition.TOP,
        );
      }
    } catch (e) {
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.error_register_with_phone_title,
        e.toString(),
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }

    MessageWidget.errorMessage(
      context,
      AppLocalizations.of(context)!.deactivate_button_title,
      AppLocalizations.of(context)!.deactivate_button_message,
      Icon(Icons.error, color: AppColors.error),
      FlushbarPosition.TOP,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator()
        : ButtonWidget(
          buttonItem: ButtonItem(
            title: AppLocalizations.of(context)!.label_login_google,
            tooltipText:
                AppLocalizations.of(context)!.tooltip_sign_in_with_google,
            enabled: false,
            routeName: RouteConstants.HOME_ROUTE,
          ),
          onPressed: (context, buttonItem) async {
            await _onPressed(context, buttonItem);
          },
          icon: Ionicons.logo_google,
        );
  }
}
