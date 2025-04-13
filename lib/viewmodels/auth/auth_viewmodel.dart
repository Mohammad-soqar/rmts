import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rmts/data/models/patient.dart' as patientModel;
import 'package:rmts/data/models/user.dart' as userModel;
import 'package:rmts/viewmodels/auth/find_glove_viewmodel.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FindGloveViewmodel _findGloveViewmodel = FindGloveViewmodel();
  userModel.User? _currentUser;
  patientModel.Patient? _currentPatient;
  bool _isLoading = false;
  String? errorMessage;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  patientModel.Patient? get currentPatient => _currentPatient;

  userModel.User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  AuthViewModel() {
    _loadCurrentUser(); // Load user on app start
  }

  // Sign In Method
  Future<String> signIn(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    String res = "Some error occurred";

    try {
      if (emailController.text.isNotEmpty ||
          passwordController.text.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        _findGloveViewmodel.findGlove();
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (e) {
      res = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return res;
  }

  // Auto Load User Session
  void _loadCurrentUser() {
    _auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          _currentUser = userModel.User.fromSnap(userDoc);

          if (_currentUser!.role.toLowerCase() == 'patient') {
            DocumentSnapshot patientDoc =
                await _firestore.collection('patients').doc(user.uid).get();
            if (patientDoc.exists) {
              _currentPatient = patientModel.Patient.fromSnap(patientDoc);
            } else {
              _setError("Patient data not found.");
            }
          }
        }
      } else {
        _currentUser = null;
      }
      notifyListeners();
    });
  }

  // Sign Out Method
  Future<void> signOut() async {
    await _auth.signOut();
    _currentUser = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    errorMessage = null;
    notifyListeners();
  }
}
