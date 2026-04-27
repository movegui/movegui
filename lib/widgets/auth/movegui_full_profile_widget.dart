
import 'package:flutter/material.dart';
import 'package:movegui/responsive.dart';

class MoveguiFullProfileWidget extends StatefulWidget {


  const MoveguiFullProfileWidget({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => MoveguiProfileScreenState();
}

class MoveguiProfileScreenState extends State<MoveguiFullProfileWidget> {

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Responsive.isDesktop(context) ? buildDesktop() : buildMobil();
    
    /*
    GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {});
      },
      child: Scaffold(
        body: Responsive.isDesktop(context) ? buildDesktop() : buildMobil(),
      ),
    );
    */
  }

  Widget buildMobil() {
    return SizedBox();

    /*
    var Size = MediaQuery.of(context).size;
    return auth?.currentUser != null
        ? Padding(
          padding: const EdgeInsets.all(0.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppImage(heightScale: 0.10),

                  Padding(
                    padding: const EdgeInsets.all(
                      WidgetConstants.sepWidgetHeight,
                    ),
                    child: ImagePickerWidget(
                      webImage: widget.webImage,
                      pickedImage: widget.pickedImage,
                      onPickImage: widget.imagePicker,
                      onRemoveImage: widget.removeImage,
                      width: Size.width * 0.40,
                      height: Size.height * 0.20,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      right: WidgetConstants.sepWidgetHeight,
                      left: WidgetConstants.sepWidgetHeight,
                    ),
                    child: GenderPicker(
                      onGenderChanged: (value) {
                        widget.onGenderChanged(value);
                      },
                      gender: widget.selectedGender,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: WidgetConstants.sepWidgetHeight,
                      left: WidgetConstants.sepWidgetHeight,
                    ),
                    child: BirthdatePicker(
                      onBirthDateChanged: (value) {
                        widget.onBirthDateChanged?.call(value);
                      },
                    ),
                  ),

                  PersonalBaseInfoWidget(
                    firstNameController: _nameController,
                    lastNameController: _prenomController,
                    addressController: _adressController,
                    firstNameFocus: _nameFocusNode,
                    lastnameFocus: _prenomFocusNode,
                    addressFocus: _adressFocusNode,
                  ),
                ],
              ),
            ),
          ),
        )
        : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MoveguiMobileImageWidget(),
              MoveguiTextWidget(),
              ButtonWidget(
                onPressed: (context, buttomItem) async {
                  _registerFCT(context, buttomItem);
                },
                buttonItem: ButtonItem(
                  AppLocalizations.of(context)!.label_login,
                  AppLocalizations.of(context)!.tooltip_sign_in,
                  true,
                  routeName: RouteContants.LOGIN_ROUTE,
                  fontSize: WidgetConstants.buttonFonsize * 1.5,
                ),
                icon: Ionicons.person,
                fontSize: 32,
              ),
            ],
          ),
        );
        */
  }

  Widget buildDesktop() {
    return SizedBox();

/*
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
          children: [AppImage()],
        ),
      ),
    );
    */
  }
}
