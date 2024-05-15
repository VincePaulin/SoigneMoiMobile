import 'package:flutter/material.dart';
import 'package:soigne_moi_mobile/screens/login/login.dart';

Widget buildLoginEmailTextField(LoginController controller) {
  return TextField(
    readOnly: controller.loading,
    autocorrect: false,
    autofocus: true,
    controller: controller.emailController,
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.emailAddress,
    style: const TextStyle(color: Colors.grey),
    decoration: InputDecoration(
      prefixIcon: const Icon(
        Icons.email_outlined,
      ),
      prefixIconColor: Colors.grey,
      errorText: controller.emailError,
      errorMaxLines: 3,
      errorStyle: const TextStyle(color: Colors.red),
      hintText: 'Email',
      hintStyle: const TextStyle(color: Colors.grey),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
    ),
  );
}

Widget buildLoginPasswordTextField(LoginController controller) {
  return TextField(
    readOnly: controller.loading,
    autocorrect: false,
    autofillHints: controller.loading ? null : [AutofillHints.password],
    controller: controller.passwordController,
    textInputAction: TextInputAction.go,
    obscureText: !controller.showPassword,
    onSubmitted: (_) => controller.login(),
    style: const TextStyle(color: Colors.grey),
    decoration: InputDecoration(
      prefixIcon: const Icon(
        Icons.lock_outlined,
      ),
      prefixIconColor: Colors.grey,
      errorText: controller.passwordError,
      errorMaxLines: 3,
      errorStyle: const TextStyle(color: Colors.red),
      suffixIconColor: Colors.grey,
      suffixIcon: IconButton(
        onPressed: controller.toggleShowPassword,
        icon: Icon(
          controller.showPassword
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
        ),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      hintText: 'Mot de passe',
      hintStyle: const TextStyle(color: Colors.grey),
    ),
  );
}

Widget buildLoginButton(LoginController controller) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: controller.loading ? null : controller.login,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 54.0),
        ),
        child: controller.loading
            ? const LinearProgressIndicator()
            : Text(
                "Connexion",
                style: const TextStyle(color: Colors.white),
              ),
      ),
    ),
  );
}
