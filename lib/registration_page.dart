import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'controllers/registration_controller.dart';
import 'home_screen.dart';

class RegistrationPage extends StatelessWidget {
  final RegistrationController _registrationController = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _registrationController.emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _registrationController.passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _registrationController.register();
                // Navigate to HomeScreen after successful registration
                Get.to(HomeScreen());
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegistrationController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Future<void> register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),  // Make sure you are using the right parameter name
        password: passwordController.text.trim(),
      );
      // You can also navigate to HomeScreen here if needed
      Get.snackbar("Success", "User registered: ${userCredential.user?.email}");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
