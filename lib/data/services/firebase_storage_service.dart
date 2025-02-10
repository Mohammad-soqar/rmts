import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance; //already connected to firebase

  Future<List<Reference>>fetchReports()
   async {
    try {
      final ref = _firebaseStorage.ref().child('reports');
      final ListResult result = await ref.listAll();
      return result.items;
     
    } catch (e) {
      throw Exception('Error fetching files: $e');
    }
  }


  
}