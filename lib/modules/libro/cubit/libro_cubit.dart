
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/libreria_controller.dart';
import 'package:flutter_app/core/controllers/libro_controller.dart';
import 'package:flutter_app/data/model/libreria_model.dart';
import 'package:flutter_app/data/model/libro_model.dart';

part 'libro_state.dart';

class LibroCubit extends Cubit<LibroState> {
  LibroCubit() : super(const LibroState());

  final LibroController _libroController = LibroController();

  Future<void> init({required int idLibreria, required int idLibro}) async{
    emit(state.copyWith(status: LibroStatus.loading));
    final libreria = LibreriaController().getById(idLibreria);

    LibroModel? libro;
    
    if(idLibro != -1){
      final libro = LibroController().getById(idLibro);
      // emit(state.copyWith(libro: libro));
    }
    emit(state.copyWith(
        libreriaModel: libreria,
        libro: libro,
        status: LibroStatus.success,
      ),
    );
    await getAll();
  }

  Future<void> getAll() async{
    emit(state.copyWith(status: LibroStatus.loading));

    final result = 
        await _libroController.getAll(idLibreria: state.libreriaModel!.id);
    
    if(result.isNotEmpty){
      emit(
        state.copyWith(
          status: LibroStatus.success,
          lsLibros: result.reversed.toList(),
        ),
      );
    } else {
      emit(state.copyWith(status: LibroStatus.failure));
    }
  }

  Future<void> insert({
    required String libroName,
    required String autor,
    required String editorial,
    required String paginas,
    required BuildContext context,
  }) async {
    emit(state.copyWith(status: LibroStatus.loading));

    final libro = LibroModel(
      libroName: libroName, 
      autor: autor, 
      editorial: editorial, 
      paginas: paginas,
    );
    libro.libreria.target = state.libreriaModel;

    final currentLibreria = state.libreriaModel;

    currentLibreria!.lsLibro.add(libro);

    final result1 = await LibreriaController().insert(
      libreriaModel: currentLibreria,
    );

    final result = await _libroController.insert(libroModel: libro);

    if(result){
      await showDialogOkInsert(context: context);
      await getAll();
    } else {
      emit(state.copyWith(status: LibroStatus.failure));
    }
  }

  Future<void> update({
    required int id,
    required String libroName,
    required String autor,
    required String editorial,
    required String paginas,
    required BuildContext context,
  }) async {
    emit(state.copyWith(status: LibroStatus.loading));

    final libro = LibroModel(
      id: id,
      libroName: libroName, 
      autor: autor, 
      editorial: editorial, 
      paginas: paginas,
    );
    libro.libreria.target = state.libreriaModel;

    final currentLibreria = state.libreriaModel;

    // currentLibreria!.lsLibro.add(libro);

    final result1 = await LibroController().updateLibro(
      libreriaModel: currentLibreria!,
    );

    final result = await _libroController.update(libroModel: libro);

    if(result){
      await showDialogOkUpdate(context: context);
      await getAll();
    } else {
      emit(state.copyWith(status: LibroStatus.failure));
    }
  }

  Future<void> delete({
    required int libroModel, 
    required BuildContext context,
  }) async{
    emit(state.copyWith(status: LibroStatus.loading));

    final result = await _libroController.delete(libroModel: libroModel);

    if(result){
      await showDialogOkRemove(context: context);
      await getAll();
    } else {
      emit(state.copyWith(status: LibroStatus.failure));
    }
  }

  Future<void> showDialogOkInsert({required BuildContext context}) async {
    await showDialog<void>(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('Libro creado'),
          content: const Text('Libro se ha creado correctamente'),
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

  Future<void> showDialogOkRemove({required BuildContext context}) async {
    await showDialog<void>(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('Libro Eliminado'),
          content: const Text('Libro se ha eliminado correctamente'),
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
