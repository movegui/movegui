import 'package:flutter/material.dart';
import 'package:movegui/consts/movegui_info.dart';
import 'package:movegui/services/assets_manager.dart';
import 'package:movegui/services/title_manager.dart';
import 'package:movegui/widgets/app/contact_widget.dart';
import 'package:movegui/widgets/title_text.dart';

class MoveguiScreen extends StatefulWidget {
  final Function(String) onTitleChange;
  const MoveguiScreen({super.key, required this.onTitleChange});

  @override
  State<StatefulWidget> createState() => MoveguiScreenState();
}

class MoveguiScreenState extends State<MoveguiScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTitleChange(TitleManager.moveguiTitle);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(6),
                margin: EdgeInsets.symmetric(horizontal: 2),
                width: MediaQuery.of(context).size.width, // 70% of screen width
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  image: DecorationImage(
                    image: AssetImage(
                      AssetsManager.moveguiIcon,
                    ), // or NetworkImage
                    fit: BoxFit.fill, // covers entire container
                    /*
                     colorFilter: ColorFilter.mode(
                        Theme.of(context).scaffoldBackgroundColor, // Change this to your desired color and opacity
                        BlendMode.color, // Other modes: overlay, multiply, etc.
                      ),
                      */
                  ),
                ),
              ),
              SizedBox(width: 8),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            MoveguiInfo.moveguiInfoTitle,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF871A1C),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          MoveguiInfo.moveguiInfoText1,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          MoveguiInfo.moveguiInfoText2,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          MoveguiInfo.moveguiInfoText3,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ContactWidget(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 130,
                child: Column(
                  children: [
                    TitlesTextWidget(
                      label: "Adresse:",
                      color: Theme.of(context).secondaryHeaderColor,
                      decoration: TextDecoration.underline,
                    ),
                    Text(
                      MoveguiInfo.moveguiInfoAdresse,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 140,
                child: Column(
                  children: [
                    TitlesTextWidget(
                      label: "E-Mail:",
                      color: Theme.of(context).secondaryHeaderColor,
                      decoration: TextDecoration.underline,
                    ),
                    Text(
                      MoveguiInfo.moveguiInfoEmail,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                child: Column(
                  children: [
                    TitlesTextWidget(
                      label: "Telephone",
                      color: Theme.of(context).secondaryHeaderColor,
                      decoration: TextDecoration.underline,
                    ),
                    Text(
                      MoveguiInfo.moveguiInfoPhone,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
