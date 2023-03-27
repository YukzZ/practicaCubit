import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/estado_controller.dart';
import 'package:flutter_app/core/controllers/libreria_controller.dart';
import 'package:flutter_app/data/model/estado_model.dart';
import 'package:flutter_app/data/model/libreria_model.dart';

part 'libreria_state.dart';

class LibreriaCubit extends Cubit<LibreriaState> {
  LibreriaCubit() : super(const LibreriaState());

  final LibreriaController _libreriaController = LibreriaController();

  Future<void> init({required int idEstado})async{
    final estado = EstadoController().getById(idEstado);
    emit(state.copyWith(estadoModel: estado));
    await getAll();
  }

  Future<void> getAll() async{
    emit(state.copyWith(status: LibreriaEstatus.loading));

    final result = 
        await _libreriaController.getAll(idEstado: state.estadoModel!.id);

    if(result.isNotEmpty){
      emit(
        state.copyWith(
          status: LibreriaEstatus.success,
          lsLibreria: result.reversed.toList(),
        ),
      );
    } else {
      emit(state.copyWith(status: LibreriaEstatus.failure));
    }
  }

  Future<void> insert({
    required String libName,
    required String direccion,
    required String telefono,
    required String correo,
    required BuildContext context,
  }) async {
    emit(state.copyWith(status: LibreriaEstatus.loading));

    final libreria = LibreriaModel(
      libName: libName, 
      direccion: direccion, 
      telefono: telefono, 
      correo: correo,
    );
    libreria.estado.target = state.estadoModel;

    final result = await _libreriaController.insert(
      libreriaModel: libreria,
    );

    if(result){
      await showDialogOkInsert(context: context);
      await getAll();
    } else {
      emit(state.copyWith(status: LibreriaEstatus.failure));
    }
  }

  Future<void> update({
    required int id,
    required String libName,
    required String direccion,
    required String telefono,
    required String correo,
    required BuildContext context,
  }) async {
    emit(state.copyWith(status: LibreriaEstatus.loading));

    final libreria = LibreriaModel(
      id: id,
      libName: libName, 
      direccion: direccion, 
      telefono: telefono, 
      correo: correo,
    );
    libreria.estado.target = state.estadoModel;

    final currentLibreria = state.estadoModel;

    // currentLibreria!.lsLibro.add(libro);

    final result1 = await LibreriaController().updateLib(
      libreriaModel: currentLibreria!,
    );

    final result = await _libreriaController.update(libreriaModel: libreria);

    if(result){
      await showDialogOkUpdate(context: context);
      await getAll();
    } else {
      emit(state.copyWith(status: LibreriaEstatus.failure));
    }
  }

  Future<void> delete({
    required int libreriaModel, 
    required BuildContext context,
  }) async{
    emit(state.copyWith(status: LibreriaEstatus.loading));

    final result = await _libreriaController.detele(libreriaModel: libreriaModel);

    if(result){
      await showDialogOkRemove(context: context);
      await getAll();
    } else {
      emit(state.copyWith(status: LibreriaEstatus.failure));
    }
  }

  Future<void> showDialogOkUpdate({required BuildContext context}) async {
    await showDialog<void>(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('Libro actualizado'),
          content: const Text('Libro se ha actualizado correctamente'),
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

  Future<void> showDialogOkInsert({required BuildContext context}) async{
    await showDialog<void>(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('Libreria creada'),
          content: const Text('La libreria se ha creado correctamente'),
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
          title: const Text('Libreria Eliminada'),
          content: const Text('Libreria se ha eliminado correctamente'),
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
