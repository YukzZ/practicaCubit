part of 'estado_cubit.dart';

class EstadoState extends Equatable {
  const EstadoState({
    this.status = EstadoEstatus.none,
    this.lsEstados = const <EstadoModel>[],
    this.estadoModel,
  });

  final EstadoEstatus status;
  final List<EstadoModel> lsEstados;
  final EstadoModel? estadoModel;

  EstadoState copyWith({
    EstadoEstatus? status,
    List<EstadoModel>? lsEstados,
    EstadoModel? estadoModel,
  }){
    return EstadoState(
      status: status ?? this.status,
      lsEstados: lsEstados ?? this.lsEstados,
      estadoModel: estadoModel ?? this.estadoModel,
      );
  }

  @override
  List<Object> get props => [status];
}

enum EstadoEstatus { none, loading, success, failure, saveOk, saveError }


