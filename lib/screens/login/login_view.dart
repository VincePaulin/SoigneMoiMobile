import 'package:flutter/material.dart';
import 'package:soigne_moi_mobile/screens/login/login.dart';

class LoginView extends StatelessWidget {
  final LoginController controller;
  const LoginView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo
            Image.asset(
              'assets/img/logo.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            // Titre
            Text(
              'Soigne Moi Docteur',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nom',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10), // Espacement entre les champs
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10), // Espacement entre les champs
                  ElevatedButton(
                    onPressed: () {
                      // Ajoutez votre logique de traitement du formulaire ici
                    },
                    child: Text('Envoyer'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
