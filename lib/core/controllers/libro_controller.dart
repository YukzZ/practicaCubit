import 'package:flutter_app/core/data_base_controller.dart';
import 'package:flutter_app/data/model/libreria_model.dart';
import 'package:flutter_app/data/model/libro_model.dart';
import 'package:flutter_app/objectbox.g.dart';

class LibroController{
  Future<List<LibroModel>> getAll({required int idLibreria}) async{
    final box = DataBaseController.store.box<LibroModel>();
    final query = box.query()
      ..link(LibroModel_.libreria, LibreriaModel_.id.equals(idLibreria));
    final lsLibro = query.build().find();

    return lsLibro;
  }

  Future<bool> insert({required LibroModel libroModel}) async {
    final box = DataBaseController.store.box<LibroModel>();
    final id = box.put(libroModel);
    return id > 0;
  }

  Future<bool> update({required LibroModel libroModel}) async {
    final box = DataBaseController.store.box<LibroModel>();
    final id = box.put(libroModel);
    return id > 0;
  }

  Future<bool> updateLibro({required LibreriaModel libreriaModel}) async{
    final box = DataBaseController.store.box<LibreriaModel>();
    final result = box.put(libreriaModel, mode: PutMode.update);
    return result > 0;
  }

  Future<bool> delete({required int libroModel}) async{
    final box = DataBaseController.store.box<LibroModel>();
    final result = box.remove(libroModel);
    return result;
  }

  LibroModel? getById(int id){
    final box = DataBaseController.store.box<LibroModel>();
    final result = box.get(id);
    return result;
  }
}
