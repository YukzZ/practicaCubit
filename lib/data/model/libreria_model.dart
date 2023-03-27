import 'package:flutter_app/data/model/estado_model.dart';
import 'package:flutter_app/data/model/libro_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class LibreriaModel {
  LibreriaModel({
    this.id = 0,
    required this.libName,
    required this.direccion,
    required this.telefono,
    required this.correo,
  });

  @Id(assignable: true)
  int id;
  final String libName;
  final String direccion;
  final String telefono;
  final String correo;

  final lsLibro = ToMany<LibroModel>();
  final estado = ToOne<EstadoModel>();
}
