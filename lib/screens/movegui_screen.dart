import 'package:flutter/material.dart';
import 'package:movegui/screens/auth/login_screen.dart';
import 'package:movegui/screens/user_screen.dart';
import 'package:movegui/services/assets_manager.dart';
import 'package:movegui/widgets/app/appbar.dart';
import 'package:movegui/widgets/app/contact_widget.dart';
import 'package:movegui/widgets/app/reklamation_widget.dart';
import 'package:movegui/widgets/menu/menu.dart';
import 'package:movegui/widgets/title_text.dart';

class MoveguiScreen extends StatelessWidget {
  const MoveguiScreen({super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MoveguiAppBar(title: 'Movegui',),
      drawer: MoveGuiMenu(),
      body: BodyWidget(),
    );
  }
}

class BodyWidget extends StatelessWidget {
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
                // child: Image.asset("assets/icons/movegui.jpg",),
              ),
              SizedBox(width: 8),
              Column(
                children: [
                  /*
                         TitlesTextWidget(
                        label: "Description",
                        color: Theme.of(context).primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      */
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Center(
                          child: Text(
                            'MoveGui – Livraison & Transport à Moto en Guinée',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF871A1C),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 24),
                        Text(
                          'MoveGui est une entreprise innovante spécialisée dans la livraison de nourriture et le transport à moto en Guinée. '
                          'Notre mission est de rendre la livraison plus accessible, plus transparente et plus économique pour tous.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Nous proposons un tarif fixe pour chaque course, quelle que soit la distance, garantissant une transparence totale pour nos clients. '
                          'Plus de surprises sur le prix, juste un service rapide, fiable et simple.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Grâce à nos partenariats avec des restaurants locaux, nous offrons des livraisons à moindre coût tout en soutenant l’économie locale. '
                          'MoveGui, c’est la fusion parfaite entre technologie, accessibilité et efficacité.',
                          style: TextStyle(
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
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitlesTextWidget(
                      label: "Addresse:",
                      color: Theme.of(context).secondaryHeaderColor,
                      decoration: TextDecoration.underline,
                    ),
                    Text(
                      'Kobaya commune de ratoma Conakry',
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
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitlesTextWidget(
                      label: "E-Mail:",
                      color: Theme.of(context).secondaryHeaderColor,
                      decoration: TextDecoration.underline,
                    ),
                    Text(
                      'movegui@gmail.com',
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
                  //              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitlesTextWidget(
                      label: "Telephone",
                      color: Theme.of(context).secondaryHeaderColor,
                      decoration: TextDecoration.underline,
                    ),
                    Text(
                      '623-259-584',
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
