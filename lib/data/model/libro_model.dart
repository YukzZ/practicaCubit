import 'package:flutter_app/data/model/libreria_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class LibroModel {
  LibroModel({
    this.id = 0,
    required this.libroName,
    required this.autor,
    required this.editorial,
    required this.paginas,
  });

  @Id(assignable: true)
  int id;
  final String libroName;
  final String autor;
  final String editorial;
  final String paginas;

  final libreria = ToOne<LibreriaModel>();
}
