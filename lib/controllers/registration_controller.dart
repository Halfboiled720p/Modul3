import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Reactive properties
  var email = ''.obs;
  var password = ''.obs;

  // Method untuk mendaftar
  Future<void> register() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      Get.snackbar('Success', 'User registered: ${userCredential.user!.email}');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
