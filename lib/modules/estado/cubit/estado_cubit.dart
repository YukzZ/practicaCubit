import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/estado_controller.dart';
import 'package:flutter_app/data/model/estado_model.dart';

part 'estado_state.dart';

class EstadoCubit extends Cubit<EstadoState> {
  EstadoCubit() : super(const EstadoState());

  final ctrl = EstadoController();

  Future<void> getAll() async{
    emit(state.copyWith(status: EstadoEstatus.loading));

    try{
      await Future<void>.delayed(const Duration(seconds: 1));
      final lsEstados = await ctrl.getAll();

      emit(state.copyWith(
        status: EstadoEstatus.success,
        lsEstados: lsEstados,
        ),
      );
    } catch (e){
      emit(state.copyWith(status: EstadoEstatus.failure));
    }
  }

  Future<void> init({required int idEstado})async{
    final estado = EstadoController().getById(idEstado);
    emit(state.copyWith(estadoModel: estado));
    await getAll();
  }

  Future<void> save({
    required String edoName, 
    required String capital, 
    required String poblacion,
    }) async {
    emit(state.copyWith(status: EstadoEstatus.loading));
    
    final estado = EstadoModel(edoName: edoName, capital: capital, poblacion: poblacion);
    final result =  await ctrl.insert(estadoModel: estado);
    if(result){
      await getAll();
    }
    else{
      emit(state.copyWith(status: EstadoEstatus.failure));
    }
    // try {
    //   ctrl.save(
    //     EstadoModel(
    //       edoName: edoName, 
    //       capital: capital, 
    //       poblacion: poblacion,
    //     ),
    //   );
    //   await getAll();
    // } catch (e) {
    //   emit(state.copyWith(status: EstadoEstatus.saveError));
    // }
  }

  Future<void> delete({
    required int libroModel, 
    required BuildContext context,
  }) async{
    emit(state.copyWith(status: EstadoEstatus.loading));

    final result = await ctrl.delete(estadoModel: libroModel);

    if(result){
      await showDialogOkRemove(context: context);
      await getAll();
    } else {
      emit(state.copyWith(status: EstadoEstatus.failure));
    }
  }

  Future<void> update({
    required int id,
    required String edoName,
    required String capital,
    required String poblacion,
    
    required BuildContext context,
  }) async {
    emit(state.copyWith(status: EstadoEstatus.loading));

    final estado = EstadoModel(
      id: id,
      edoName: edoName, 
      capital: capital, 
      poblacion: poblacion, 
      
    );
    //estado.estado.target = state.estadoModel;

    final currentEstado = state.estadoModel;

    // currentLibreria!.lsLibro.add(libro);

    // final result1 = await EstadoController().update(
    //   estadoModel: currentEstado!,
    // );

    final result = await ctrl.update(estadoModel: estado);

    if(result){
      await showDialogOkUpdate(context: context);
      await getAll();
    } else {
      emit(state.copyWith(status: EstadoEstatus.failure));
    }
  }

  Future<void> showDialogOkUpdate({required BuildContext context}) async {
    await showDialog<void>(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('Estado actualizado'),
          content: const Text('Estado se ha actualizado correctamente'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  Future<void> showDialogOkRemove({required BuildContext context}) async {
    await showDialog<void>(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('Estado Eliminado'),
          content: const Text('Estado se ha eliminado correctamente'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
