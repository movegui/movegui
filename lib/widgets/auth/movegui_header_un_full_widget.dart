import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/models/user_model.dart';
import 'package:movegui/widgets/auth/movegui_profile_default_image.dart';
import 'package:movegui/widgets/auth/movegui_profile_header_update_name.dart';
import 'package:movegui/widgets/subtitle_text.dart';

class MoveguiHeaderUnFullWidget extends StatefulWidget {
  final UserModel? currentUser;
  final File? pickedImage;
  final Uint8List? webImage;
  final Future<void> Function(String?) onNameUpdate;
  final Future<void> Function() onPickImage;
  final TextEditingController nameController;
  final FocusNode nameFocusNode;

  const MoveguiHeaderUnFullWidget({
    super.key,
    required this.currentUser,
    required this.pickedImage,
    required this.webImage,
    required this.onNameUpdate,
    required this.onPickImage,
    required this.nameController,
    required this.nameFocusNode,
  });
  @override
  State<StatefulWidget> createState() => MoveguiHeaderUnFullWidgetState();
}

class MoveguiHeaderUnFullWidgetState extends State<MoveguiHeaderUnFullWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildHeader();
  }

  Widget _buildHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.currentUser?.personModel?.profileImageUrl == null)
          MoveguiProfileDefaultImage(
            onPickImage: widget.onPickImage,
            pickedImage: widget.pickedImage,
            webImage: widget.webImage,
          ),

        if ((widget.currentUser?.name ?? '').trim().isEmpty)
          MoveguiProfileHeaderUpdateName(
            nameController: widget.nameController,
            nameFocusNode: widget.nameFocusNode,
            onNameUpdate: widget.onNameUpdate, // ✅ fix this
          )
        else
          SubtitleTextWidget(
            label: widget.currentUser!.name,
            fontSize: WidgetConstants.sepWidgetHeight * 3,
          ),
      ],
    );
  }
}
