
import 'package:flutter_app/core/data_base_controller.dart';
import 'package:flutter_app/data/model/estado_model.dart';
import 'package:flutter_app/data/model/libreria_model.dart';
import 'package:flutter_app/objectbox.g.dart';

class LibreriaController {
  Future<List<LibreriaModel>> getAll({required int idEstado}) async{
    final box = DataBaseController.store.box<LibreriaModel>();
    final query = box.query()
      ..link(LibreriaModel_.estado, EstadoModel_.id.equals(idEstado));

      final lsLibreria = query.build().find();

      return lsLibreria;
  }

  Future<bool> insert({required LibreriaModel libreriaModel}) async {
    final box = DataBaseController.store.box<LibreriaModel>();
    final id = box.put(libreriaModel);
    return id > 0;
  }

  Future<bool> update({required LibreriaModel libreriaModel}) async{
    final box = DataBaseController.store.box<LibreriaModel>();
    final result = box.put(libreriaModel, mode: PutMode.update);
    return result > 0;
  }

  Future<bool> updateLib({required EstadoModel libreriaModel}) async{
    final box = DataBaseController.store.box<EstadoModel>();
    final result = box.put(libreriaModel, mode: PutMode.update);
    return result > 0;
  }

  Future<bool> detele({required int libreriaModel}) async{
    final box = DataBaseController.store.box<LibreriaModel>();
    final result = box.remove(libreriaModel);
    return result;
  }

  LibreriaModel? getById(int id) {
    final box = DataBaseController.store.box<LibreriaModel>();
    final result = box.get(id);
    return result;
  }
}
