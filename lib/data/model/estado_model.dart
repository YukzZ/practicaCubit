import 'package:flutter_app/data/model/libreria_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class  EstadoModel {
  EstadoModel({
    this.id = 0, 
    required this.edoName, 
    required this.capital, 
    required this.poblacion,
  });

  @Id(assignable: true)
  int id;
  final String edoName;
  final String capital;
  final String poblacion;

  final lsLibreria = ToMany<LibreriaModel>();
}
