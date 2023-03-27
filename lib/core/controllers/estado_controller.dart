import 'package:flutter_app/core/data_base_controller.dart';
import 'package:flutter_app/data/model/estado_model.dart';
import 'package:flutter_app/objectbox.g.dart';

class EstadoController{
  Future<List<EstadoModel>> getAll() async{
    final box = DataBaseController.store.box<EstadoModel>();
    final lsEstados = box.getAll();
    return lsEstados;
  }

  void save(EstadoModel estado){
    final box = DataBaseController.store.box<EstadoModel>();
    box.put(estado);
  }

  Future <bool> insert ({required EstadoModel estadoModel}) async{
    final box = DataBaseController.store.box<EstadoModel>();
    final id = box.put(estadoModel);
    return id > 0;
  }

  EstadoModel? getById(int id){
    final box = DataBaseController.store.box<EstadoModel>();
    final estado = box.get(id);

    return estado;
  }
  Future<bool> delete({required int estadoModel}) async{
    final box = DataBaseController.store.box<EstadoModel>();
    final result = box.remove(estadoModel);
    return result;
  }

  Future<bool> update({required EstadoModel estadoModel}) async{
    final box = DataBaseController.store.box<EstadoModel>();
    final result = box.put(estadoModel, mode: PutMode.update);
    return result > 0;
  }
}
