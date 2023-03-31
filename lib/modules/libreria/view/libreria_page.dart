

import 'package:flutter/material.dart';
import 'package:flutter_app/data/model/libro_model.dart';
import 'package:flutter_app/modules/libreria/cubit/libreria_cubit.dart';
import 'package:flutter_app/modules/libreria/view/libreria_detalle_page.dart';
import 'package:flutter_app/modules/libro/view/libro_detalle_pager.dart';
import 'package:flutter_app/modules/libro/view/libro_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibreriaPage extends StatefulWidget {
  const LibreriaPage({super.key, required this.idEstado});

  final int idEstado;

  @override
  State<LibreriaPage> createState() => _LibreriaPageState();
}

class _LibreriaPageState extends State<LibreriaPage> {
  late LibreriaCubit _cubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Libreria'),
      ),
      body: BlocProvider(
        create: (context) => LibreriaCubit()
          ..init(idEstado: widget.idEstado),
        child: BlocBuilder<LibreriaCubit, LibreriaState>(
          builder: (context, state) {
            _cubit = context.read<LibreriaCubit>();
            Widget child = const Center(child: Text('No hay datos'),);
            if(state.status == LibreriaEstatus.loading){
              child = const Center(child: CircularProgressIndicator(),);
            } else if (state.status == LibreriaEstatus.success){
              child = ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.lsLibreria.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async{
                      await Navigator.push(
                        context, 
                        MaterialPageRoute<void>(
                          builder: (context) => LibroPage(
                            idLibreria: state.lsLibreria[index].id,
                          ),
                        ),
                      ).then((value) => _cubit.init(idEstado: widget.idEstado));
                    },
                    child: Column(
                      children: [
                        ListTile(
                          trailing: ElevatedButton(
                            onPressed: () async {
                              await Navigator.push(
                                context, 
                                MaterialPageRoute<void>(
                                  builder: (context) => LibreriaDetallePage(
                                    idEstado: widget.idEstado,
                                    id: state.lsLibreria[index].id,
                                    libName: state.lsLibreria[index].libName, 
                                    direccion: state.lsLibreria[index].direccion,
                                    telefono: state.lsLibreria[index].telefono, 
                                    correo: state.lsLibreria[index].correo,
                                  ),
                                ),
                              );
                            }, 
                            child: const Icon(Icons.add),
                          ),
                          leading: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255, 231, 76, 60,
                              ),
                              
                            ),
                                onPressed: () {
                                  _cubit.delete(
                                    libreriaModel: state.lsLibreria[index].id, 
                                    context: context,
                                  );
                                }, 
                                child: const Icon(Icons.remove,),
                              ),
                          title: Text(state.lsLibreria[index].libName),
                        ),
                        listLibros(
                          lsLibros: state.lsLibreria[index].lsLibro,
                          id: state.lsLibreria[index].id,
                          
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              child = const Center(child: Text('No hay datos'),);
            }
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'Estado: ${state.estadoModel!.edoName}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  formNewLibreria(),
                  Expanded(child: child),
                ],
              ),
            );
          },
        ),
      ),

    );
  }

  Widget listLibros({
    required List<LibroModel> lsLibros, 
    required int id,
    
    }){
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Card(
            color: const Color.fromARGB(255, 214, 234, 248),
            child: InkWell(
              onTap: () async{
                await Navigator.push(
                          context, 
                          MaterialPageRoute<void>(
                            builder: (context) => LibroDetallePage(
                              id: lsLibros[index].id,
                              libroName: lsLibros[index].libroName,
                              autor: lsLibros[index].autor,
                              editorial: lsLibros[index].editorial,
                              paginas: lsLibros[index].paginas,
                            ),
                          ),
                        );
              },
              child: ListTile(
                
                title: Text(
                  lsLibros[index].libroName,
                ),
              ),
            ),
          ),
        );
      },
      itemCount: lsLibros.length,
    );
  }

  final controllerLibName = TextEditingController();
  final controllerCorreo = TextEditingController();
  final controllerDireccion = TextEditingController();
  final controllerTelefono = TextEditingController();
  Widget formNewLibreria(){
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Nombre de la libreria',
          ),
          controller: controllerLibName,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Correo de la libreria',
          ),
          controller: controllerCorreo,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Direccion de la libreria',
          ),
          controller: controllerDireccion,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Telefono de la libreria',
          ),
          controller: controllerTelefono,
        ),
        ElevatedButton(
          onPressed: () {
            _cubit.insert(
              libName: controllerLibName.text, 
              direccion: controllerDireccion.text, 
              telefono: controllerTelefono.text, 
              correo: controllerCorreo.text, 
              context: context,
            );
            controllerCorreo.clear();
            controllerDireccion.clear();
            controllerLibName.clear();
            controllerTelefono.clear();
          }, 
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
