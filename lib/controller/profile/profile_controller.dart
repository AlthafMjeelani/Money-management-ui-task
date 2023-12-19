import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:demotask/model/user_model.dart';
import 'package:demotask/view/Authentication/screen_signin.dart';

class ProfileProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobController = TextEditingController();

  final TextEditingController dobController = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  File? image;
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  UserModel? userModel;

  bool isEditing = false;
  String? downloadUrl;
  Future<void> getImage(ImageSource source) async {
    final pikImage = await ImagePicker().pickImage(
      source: source,
    );
    if (pikImage == null) {
      return;
    } else {
      final imageTemp = File(pikImage.path);
      image = imageTemp;
      notifyListeners();
      log("image picked ");
    }
  }

  void setDob(String date) {
    dobController.text = date;
    notifyListeners();
  }

  Future<void> signOutPage(context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signOut();
      downloadUrl = null;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (ctx) => const ScreenSignIn(),
        ),
        (route) => false,
      );
      log('called');
    } catch (e) {
      log(
        e.toString(),
      );
    }
  }

  Future<void> uploeadPick(String? userid) async {
    Reference reference =
        FirebaseStorage.instance.ref().child('$userid/images');
    await reference.putFile(image!);
    notifyListeners();
  }

  void getProfileImage(String? userid) async {
    try {
      _isLoading = true;
      notifyListeners();
      Reference reference =
          FirebaseStorage.instance.ref().child('$userid/images');
      downloadUrl = await reference.getDownloadURL();
      _isLoading = false;
      notifyListeners();
      log(downloadUrl!);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      log('getImageException${e.toString()}');
    }
  }

  Future<void> getData() async {
    try {
      notifyListeners();
      await FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.email.toString())
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        userModel = UserModel.fromMap(value.data()!);
        emailController.text = userModel!.email.toString();
        dobController.text = userModel!.dob.toString();

        mobController.text = userModel!.mob.toString();
        nameController.text = userModel!.name.toString();
        notifyListeners();
        log(userModel.toString());
      });
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> submitUpdate(String? userid, context) async {
    try {
      if (formKey.currentState!.validate()) {
        _isLoading = true;
        notifyListeners();
        if (image != null) {
          _isLoading = true;
          notifyListeners();
          await uploeadPick(userid);
        } else {
          log('not called');
        }

        UserModel userModel = UserModel(
          email: auth.currentUser!.email.toString(),
          name: nameController.text,
          mob: mobController.text,
          dob: dobController.text,
        );
        await firebaseFirestore
            .collection(auth.currentUser!.email.toString())
            .doc(auth.currentUser!.uid)
            .update(userModel.toMap());
        _isLoading = false;
        isEditing = false;
        notifyListeners();
        log('submit called');
        //  Navigator.pop(context);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  String? validation(value, String text) {
    if (value == null || value.isEmpty) {
      return text;
    }
    return null;
  }

  String? phoneValidation(String? value) {
    if (value == null || value.isEmpty || value.length != 10) {
      return 'please enter 10 numbers';
    }
    return null;
  }
}
