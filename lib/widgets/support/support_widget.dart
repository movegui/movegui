import 'package:flutter/material.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/user_model.dart';
import 'package:movegui/services/global_method.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/services/user_service.dart';
import 'package:movegui/widgets/util/display_widget.dart';

class SupportWidget extends StatefulWidget {
  final String? title;
  const SupportWidget({super.key ,  this.title});

  @override
  State<StatefulWidget> createState() => SupportWidgetState();
}

class SupportWidgetState extends State<SupportWidget> {
  late UserModel? user;
  late UserService userService;
  String? name = 'MoveGui';

  @override
  void initState() {
    userService = getIt<UserService>();
    user = null;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final config = await userService.loadConfig();
      final email = config['support.email'] as String?;
       name = config['support.name'] as String?;
      if (email != null) {
        final supportUser = await userService.getByEmail(email);
        user = supportUser != null ? supportUser : null;
        setState(() {
          
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null)
      return Card(
        child: Text(AppLocalizations.of(context)!.error_user_not_found_message),
      );
   
       user?.personModel?.name = name!; 
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            user?.personModel?.profileImageUrl ??
               'assets/icons/movegui.jpg',
          ),
        ),
        title: DisplayWidget(
          text: widget.title ?? name,
          textAlign: TextAlign.left,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        subtitle: Row(
          children: [
            SizedBox(
              // width:  ,
              child: DisplayWidget(text: user?.role, textAlign: TextAlign.left),
            ),
            const SizedBox(width: 8), // spacing between role and status
            SizedBox(
              width: 10,
              child: Icon(
                Icons.circle,
                size: 12,
                color: user!.isActive ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
        onTap: () {
          GlobalMethods.showUserBottomSheet(context: context, model: user!);
        },
      ),
    );
  }
}
