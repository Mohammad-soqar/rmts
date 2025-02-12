import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rmts/data/models/glove.dart';

class GloveService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collection = 'Gloves';



  // 1: Implement the getGlove method
  Future<Glove> getGloveById(String gloveId) async {
    DocumentSnapshot snapshot = await _firestore.collection(collection).doc(gloveId).get();
    return Glove.fromSnap(snapshot);
  }

  // 2: Implement the addGlove method
  Future addGlove(Glove glove) async {
    await   _firestore.collection(collection).add(glove.toJson());  
  }

  // 3: Implement the updateGlove method
  Future<void> updateGlove(Glove glove) async {
    await _firestore.collection(collection).doc(glove.gloveId).update(glove.toJson());
  }

}