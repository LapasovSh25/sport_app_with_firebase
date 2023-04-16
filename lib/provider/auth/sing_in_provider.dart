import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sport_app_with_api/helpers/show_message_helper.dart';

class SingInProvider extends ChangeNotifier {
  //controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //variables
  bool isLoading = false;

  //to user sing up
  Future<dynamic> singIn() async {
    try {
      isLoading = true;
      notifyListeners(); 
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showErrorMessage("user topilmadi");
        isLoading = false;
        notifyListeners();
      } else if (e.code == 'wrong-password') {
        showErrorMessage("noto'g'ri parol");
        isLoading = false;
        notifyListeners();
      } else {
        showErrorMessage("Noma'lum xato");
        isLoading = false;
        notifyListeners();
      }
    }
  }
}
