import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:sport_app_with_api/helpers/show_message_helper.dart';

class SingUpProvider extends ChangeNotifier {
  //controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  //variables
  bool isLoading = false;


  //to user sing up
  Future<dynamic> singUp() async {
    try {
      isLoading = true;
      notifyListeners();
      UserCredential authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      isLoading = false;
      notifyListeners();
      String userId = authResult.user!.uid;
      
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
      DocumentReference newUserDoc = usersCollection.doc(userId);
      await newUserDoc.set({
        'name': nameController.text,
        'last_name': lastNameController.text,
        'email': emailController.text,
        'created_at': DateTime.now(),
        'user_id': userId,
      });
      print('User data saved successfully');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showErrorMessage("Kuchsiz parol");
        isLoading = false;
        notifyListeners();
      } else if (e.code == 'email-already-in-use') {
        showErrorMessage("Email ishlatilgan");
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
