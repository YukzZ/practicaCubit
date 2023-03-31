

import 'package:flutter/material.dart';
import 'package:flutter_app/modules/libro/cubit/libro_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibroDetallePage extends StatefulWidget {
  const LibroDetallePage({
    super.key, 
    this.id=0,
     this.idLibreria=0,
    required this.libroName,
    required this.autor,
    required this.editorial,
    required this.paginas,
  });
  final int id;
  final int idLibreria;
  final String libroName;
  final String autor;
  final String editorial;
  final String paginas;

  @override
  State<LibroDetallePage> createState() => _LibroDetallePageState();
}

class _LibroDetallePageState extends State<LibroDetallePage> {
  late LibroCubit _cubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de Libro ${widget.libroName}'),
      ),
      body: BlocProvider(
        create: (context) => LibroCubit()..init(
          idLibreria: widget.idLibreria, 
          idLibro: widget.id,
        ),
        child: BlocBuilder<LibroCubit, LibroState>(
          builder: (context, state) {
            _cubit = context.read<LibroCubit>();
            
            
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child:  Text(
                        'Datos del Libro',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox( height: 10,),
                    Text(
                      'Libro: ${widget.libroName}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox( height: 10,),
                    Text(
                      'Autor: ${widget.autor}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox( height: 10,),
                    Text(
                      'Editorial: ${widget.editorial}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox( height: 10,),
                    Text(
                      'Paginas: ${widget.paginas}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox( height: 20,),
                    const Divider(),
                    formUpdateLibro(widget.id),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      
    );
  }
  final controllerLibroName = TextEditingController();
  final controllerAutor = TextEditingController();
  final controllerEditorial = TextEditingController();
  final controllerPaginas = TextEditingController();
  Widget formUpdateLibro(int id){
    String libroName, autor, editorial, paginas;
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Nombre del Libro',
          ),
          controller: controllerLibroName,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Nombre del autor',
          ),
          controller: controllerAutor,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Nombre de la editorial',
          ),
          controller: controllerEditorial,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Numero de paginas',
          ),
          controller: controllerPaginas,
        ),
        const SizedBox( height: 10,),
        ElevatedButton(
          onPressed: () {
            if(controllerLibroName.text.isEmpty){
              libroName = widget.libroName;
            }else{
              libroName = controllerLibroName.text;
            }
            if(controllerAutor.text.isEmpty){
              autor = widget.autor;
            }else{
              autor = controllerAutor.text;
            }
            if(controllerEditorial.text.isEmpty){
              editorial = widget.editorial;
            }else{
              editorial= controllerEditorial.text;
            }
            if(controllerPaginas.text.isEmpty){
              paginas = widget.paginas;
            }else {
              paginas = controllerPaginas.text;
            }
            _cubit.update(
              id: id,
              libroName: libroName, 
              autor: autor, 
              editorial: editorial, 
              paginas: paginas, 
              context: context,
            );
            controllerAutor.clear();
            controllerEditorial.clear();
            controllerLibroName.clear();
            controllerPaginas.clear();
          }, 
          child: const Text('Editar'),
        )
      ],
    );
  }
}
