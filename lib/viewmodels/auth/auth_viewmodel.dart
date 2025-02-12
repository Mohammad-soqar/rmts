import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rmts/data/models/patient.dart' as patientModel;
import 'package:rmts/data/models/user.dart' as userModel;

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  userModel.User? _currentUser;
  patientModel.Patient? _currentPatient;
  bool _isLoading = false;
  String? errorMessage;

  patientModel.Patient? get currentPatient => _currentPatient;

  userModel.User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  AuthViewModel() {
    _loadCurrentUser(); // Load user on app start
  }

  // Sign In Method
  Future<void> signIn(String email, String password) async {
    _setLoading(true);
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();

      if (userDoc.exists) {
        _currentUser = userModel.User.fromSnap(userDoc);
        _clearError();
        if (_currentUser!.role.toLowerCase() == 'patient') {
          DocumentSnapshot patientDoc =
              await _firestore.collection('patients').doc(uid).get();
          if (patientDoc.exists) {
            _currentPatient = patientModel.Patient.fromSnap(patientDoc);
          } else {
            _setError("Patient data not found.");
          }
        }
      } else {
        _setError("User not found in database.");
      }
    } catch (e) {
      _setError("Login failed: ${e.toString()}");
    } finally {
      _setLoading(false);
    }
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
