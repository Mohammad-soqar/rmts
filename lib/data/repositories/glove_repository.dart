
import 'package:rmts/data/models/glove.dart';
import 'package:rmts/data/services/glove_service.dart';

class GloveRepository {
  final GloveService _gloveService = GloveService();


  Future<Glove> fetchGlove(String gloveId) async{
    try{
      return _gloveService.getGloveById(gloveId);
    } catch(e){
      throw Exception('Failed to fetch Glove: $e');
    }
  }

  Future<void> addGlove(Glove glove) async{
    try{
      return _gloveService.addGlove(glove);
    } catch(e){
      throw Exception('Failed to add Glove: $e');
    }
  }

  Future<void> updateGlove(Glove glove) async{
    try{
      return _gloveService.updateGlove(glove);
    } catch(e){
      throw Exception('Failed to update Glove: $e');
    }
  }

 
}