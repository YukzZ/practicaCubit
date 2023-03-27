

import 'package:flutter/material.dart';
import 'package:flutter_app/modules/libro/cubit/libro_cubit.dart';
import 'package:flutter_app/modules/libro/view/libro_detalle_pager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibroPage extends StatefulWidget {
  const LibroPage({super.key, required this.idLibreria});

  final int idLibreria;

  @override
  State<LibroPage> createState() => _LibroPageState();
}

class _LibroPageState extends State<LibroPage> {
  late LibroCubit _cubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Libro'),
      ),
      body: BlocProvider(
        create: (context) => LibroCubit()
            ..init(idLibreria: widget.idLibreria),
        child: BlocBuilder<LibroCubit, LibroState>(
          builder: (context, state) {
            _cubit = context.read<LibroCubit>();
            Widget childWidget = const Center(child: Text('No hay datos'),);
            if(state.status == LibroStatus.loading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if ( state.status == LibroStatus.success){
              childWidget = ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context, 
                        MaterialPageRoute<void>(
                          builder: (context) => LibroDetallePage(
                            idLibreria: widget.idLibreria,
                            id: state.lsLibros[index].id,
                            libroName: state.lsLibros[index].libroName,
                            autor: state.lsLibros[index].autor,
                            editorial: state.lsLibros[index].editorial,
                            paginas: state.lsLibros[index].paginas,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                       ElevatedButton(
                        style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255, 231, 76, 60,
                              ),
                              
                            ),
                            onPressed: () {
                              _cubit.delete(
                                libroModel: state.lsLibros[index].id, 
                                context: context,
                              );
                            }, 
                            child: const Icon(Icons.remove),
                          ),
                          const SizedBox(width: 20,),
                       Text(state.lsLibros[index].libroName),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.lsLibros.length,
              );
            } else {
              childWidget = const Center(child: Text('No hay datos'),);
            }
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'Libreria: ${state.libreriaModel!.libName}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  formNewLibro(),
                  Expanded(child: childWidget),
                ],
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
  Widget formNewLibro(){
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
        ElevatedButton(
          onPressed: () {
            _cubit.insert(
              
              libroName: controllerLibroName.text, 
              autor: controllerAutor.text, 
              editorial: controllerEditorial.text, 
              paginas: controllerPaginas.text, 
              context: context,
            );
            controllerAutor.clear();
            controllerEditorial.clear();
            controllerLibroName.clear();
            controllerPaginas.clear();
          }, 
          child: const Text('Guardar'),
        )
      ],
    );
  }
}
