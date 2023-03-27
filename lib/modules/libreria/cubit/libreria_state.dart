part of 'libreria_cubit.dart';

 class LibreriaState extends Equatable {
  const LibreriaState({
    this.status = LibreriaEstatus.initial,
    this.lsLibreria = const [],
    this.estadoModel,
  });

  final LibreriaEstatus status;
  final List<LibreriaModel> lsLibreria;
  final EstadoModel? estadoModel;

  LibreriaState copyWith({
    LibreriaEstatus? status,
    List<LibreriaModel>? lsLibreria,
    EstadoModel? estadoModel,
  }){
    return LibreriaState(
      status: status ?? this.status,
      lsLibreria: lsLibreria ?? this.lsLibreria,
      estadoModel: estadoModel ?? this.estadoModel,
    );
  }

  @override
  List<Object> get props => [status];
}

enum LibreriaEstatus {initial, loading, success, failure }


