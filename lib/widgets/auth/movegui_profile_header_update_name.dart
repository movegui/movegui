import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/widgets/util/input_name_widget.dart';

class MoveguiProfileHeaderUpdateName extends StatelessWidget{

  final TextEditingController nameController;
  final FocusNode nameFocusNode;
  final Future<void> Function(String?) onNameUpdate;
  

   MoveguiProfileHeaderUpdateName({super.key, required this.nameController, required this.nameFocusNode, required this.onNameUpdate});

  @override
  Widget build(BuildContext context) {
   return  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InputNameWidget(
                        nameController: nameController,
                        nameFocusNode: nameFocusNode,
                        hinterText:
                            AppLocalizations.of(context)!.input_hint_first_name,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        onNameUpdate(nameController.text);
                      },
                      child:  CircleAvatar(
                        radius: 16,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Icon(
                          IconlyLight.send,
                          size: 12,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        nameController.clear();
                      },
                      child:  CircleAvatar(
                        radius: 16,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Icon(
                          Icons.cancel,
                          size: 16,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
            
              );
  }
}