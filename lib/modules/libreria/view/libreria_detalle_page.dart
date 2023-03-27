

import 'package:flutter/material.dart';
import 'package:flutter_app/modules/libreria/cubit/libreria_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibreriaDetallePage extends StatefulWidget {
  const LibreriaDetallePage({
    super.key, 
    this.id=0,
     this.idEstado=0,
    required this.libName,
    required this.direccion,
    required this.telefono,
    required this.correo,
  });
  final int id;
  final int idEstado;
  final String libName;
  final String direccion;
  final String telefono;
  final String correo;

  @override
  State<LibreriaDetallePage> createState() => _LibreriaDetallePageState();
}

class _LibreriaDetallePageState extends State<LibreriaDetallePage> {
  late LibreriaCubit _cubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de libreria ${widget.libName}'),
      ),
      body: BlocProvider(
        create: (context) => LibreriaCubit()..init(idEstado: widget.idEstado),
        child: BlocBuilder<LibreriaCubit, LibreriaState>(
          builder: (context, state) {
            _cubit = context.read<LibreriaCubit>();
            
            
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child:  Text(
                        'Datos del libreria',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox( height: 10,),
                    Text(
                      'Libreria: ${widget.libName}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox( height: 10,),
                    Text(
                      'Direccion: ${widget.direccion}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox( height: 10,),
                    Text(
                      'Telefono: ${widget.telefono}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox( height: 10,),
                    Text(
                      'Correo: ${widget.correo}',
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
  final controllerLibName = TextEditingController();
  final controllerDireccion = TextEditingController();
  final controllerTelefono = TextEditingController();
  final controllerCorreo = TextEditingController();
  Widget formUpdateLibro(int id){
    String libName, direccion, telefono, correo;
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
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Correo de la libreria',
          ),
          controller: controllerCorreo,
        ),
        const SizedBox( height: 10,),
        ElevatedButton(
          onPressed: () {
            if(controllerLibName.text.isEmpty){
              libName = widget.libName;                                          
            } else{
              libName = controllerLibName.text;                          
            }
            if(controllerCorreo.text.isEmpty){
              correo = widget.correo;
            } else{
              correo = controllerCorreo.text;
            }
            if(controllerDireccion.text.isEmpty){
              direccion = widget.direccion;
            }else{
              direccion = controllerDireccion.text;
            }
            if(controllerTelefono.text.isEmpty){
              telefono = widget.telefono;
            }else{
              telefono = controllerTelefono.text;
            }
            _cubit.update(
              id: id,
              libName: libName, 
              direccion: direccion, 
              telefono: telefono, 
              correo: correo, 
              context: context,
            );
            controllerDireccion.clear();
            controllerTelefono.clear();
            controllerLibName.clear();
            controllerCorreo.clear();
          }, 
          child: const Text('Editar'),
        )
      ],
    );
  }
}
