import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rmts/data/models/glove.dart';

class GloveService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collection = 'Gloves';

  // 1: Implement the getGlove method
  Future<Glove> getGloveById(String gloveId) async {
    DocumentSnapshot snapshot =
        await _firestore.collection(collection).doc(gloveId).get();
    return Glove.fromSnap(snapshot);
  }

  Future addGlove(Glove glove) async {
    try {
      // Step 1: Create docRef with custom ID (before writing)
      DocumentReference docRef = _firestore.collection(collection).doc();
      String gloveId = docRef.id;

      // Step 2: Generate glove name from the ID
      String gloveName = 'RA_Glove_GLOV${gloveId.substring(0, 4)}';

      // Step 3: Create a full map to write
      final gloveData = {
        'status': glove.status.toString().split('.').last,
        'gloveName': gloveName,
        'patientId': glove.patientId,
        'model': glove.model,
        'version': glove.version,
        'productionDate': glove.productionDate,
        'lastSynced': glove.lastSynced,
        'lastUpdated': glove.lastUpdated,
        'lastCalibrated': glove.lastCalibrated,
      };

      // Step 4: Set it once — now all fields are complete
      await docRef.set(gloveData);

      print('✅ Glove added with ID: $gloveId and Name: $gloveName');
    } catch (e) {
      print('❌ Error adding glove: $e');
    }
  }

  // 3: Implement the updateGlove method
  Future<void> updateGlove(Glove glove) async {
    await _firestore
        .collection(collection)
        .doc(glove.gloveId)
        .update(glove.toJson());
  }
}
