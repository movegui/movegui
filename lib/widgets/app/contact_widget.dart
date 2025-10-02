import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/validator.dart';

class ContactWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ContactScreen();
    /*
    MaterialApp(
      title: 'Formulaire de Contact MoveGui',
      debugShowCheckedModeBanner: false,
      home: ReclamationScreen(),
    );
    */
  }
}

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late final TextEditingController _vorNameController,
      _nameController,
      _emailController,
      _telefonController,
      _reclamationController;

  late final FocusNode _vorNameFocusNode,
      _nameFocusNode,
      _emailFocusNode,
      _telefonFocusNode,
      _reclamationFocusNode;

  late final _formKey;

  @override
  void initState() {
    _vorNameController = TextEditingController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _telefonController = TextEditingController();
    _reclamationController = TextEditingController();
    _formKey = GlobalKey<FormState>();

    _vorNameFocusNode = FocusNode();
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _telefonFocusNode = FocusNode();
    _reclamationFocusNode = FocusNode();

    super.initState();
  }

  void _envoyerReclamation() {
    if (_formKey.currentState!.validate()) {
      final message = _reclamationController.text;

      // Ici vous pouvez envoyer la réclamation à votre serveur ou la traiter comme souhaité
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text('Réclamation envoyée'),
              content: Text('Merci pour votre message :\n\n$message'),
              actions: [
                TextButton(
                  child: Text('Fermer'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
      );

      // Réinitialise le champ après envoi
      _reclamationController.clear();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _reclamationController.dispose();
    _vorNameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _telefonController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
    /*
    Scaffold(

      appBar: AppBar(
        title: Text('Formulaire de Réclamation'),
        backgroundColor: Colors.blueAccent,
      ),
      body: 
      */
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Formulaire de Contact:', 
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, color: Color(0xFF871A1C))),
            TextFormField(
              controller: _nameController,
              focusNode: _nameFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Nom:',
                prefixIcon: Icon(Icons.person),
              ),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_vorNameFocusNode);
              },
              validator: (value) {
                return MyValidators.displayNamevalidator(value);
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _vorNameController,
              focusNode: _vorNameFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Prenom:',
                prefixIcon: Icon(Icons.person),
              ),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_emailFocusNode);
              },
              validator: (value) {
                return MyValidators.displayNamevalidator(value);
              },
            ),
            const SizedBox(height: 16.0),

             TextFormField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Addresse Email",
              prefixIcon: Icon(IconlyLight.message),
            ),
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(_telefonFocusNode);
            },
            validator: (value) {
              return MyValidators.emailValidator(value);
            },
          ),

           const SizedBox(height: 16.0),
            TextFormField(
              controller: _telefonController,
              focusNode: _telefonFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Telephone:',
                prefixIcon: Icon(Icons.phone),
              ),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_emailFocusNode);
              },
              validator: (value) {
                return MyValidators.displayNamevalidator(value);
              },
            ),
            const SizedBox(height: 16.0),

            SizedBox(height: 16),
            TextFormField(
              controller: _reclamationController,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Votre message...',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Veuillez entrer votre message.';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.send),
                label: Text('Envoyer', style: TextStyle(color: AppColors.textColor),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backgroundColor,
                  iconColor: AppColors.textColor,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: _envoyerReclamation,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
