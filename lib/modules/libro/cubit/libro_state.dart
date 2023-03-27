part of 'libro_cubit.dart';

class LibroState extends Equatable {
  const LibroState({
    this.status = LibroStatus.initial,
    this.lsLibros = const <LibroModel>[],
    this.libro,
    this.libreriaModel,
  });

  final LibroStatus status;
  final List<LibroModel> lsLibros;
  final LibroModel? libro;
  final LibreriaModel? libreriaModel;

  LibroState copyWith({
    LibroStatus? status,
    List<LibroModel>? lsLibros,
    LibroModel? libro,
    LibreriaModel? libreriaModel,
  }){
    return LibroState(
      status: status ?? this.status,
      lsLibros: lsLibros ?? this.lsLibros,
      libro: libro ?? this.libro,
      libreriaModel: libreriaModel ??  this.libreriaModel,
    );
  }

  @override
  List<Object> get props => [status, lsLibros];
}

enum LibroStatus {initial, loading, success, failure}
