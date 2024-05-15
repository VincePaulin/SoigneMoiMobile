import 'package:flutter/material.dart';
import 'package:soigne_moi_mobile/widgets/auth_widget.dart';
import 'login.dart';

class LoginView extends StatelessWidget {
  final LoginController controller;
  const LoginView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
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
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    // Email TextField
                    buildLoginEmailTextField(controller),
                    const SizedBox(height: 10),
                    // Password TextField
                    buildLoginPasswordTextField(controller),
                    const SizedBox(height: 10),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Mot de passe oublié ?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Login Button
                buildLoginButton(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
