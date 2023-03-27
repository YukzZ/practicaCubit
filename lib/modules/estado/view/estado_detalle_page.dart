

import 'package:flutter/material.dart';
import 'package:flutter_app/modules/estado/cubit/estado_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EstadoDetallePage extends StatefulWidget {
  const EstadoDetallePage({
    super.key, 
    this.id=0,
     this.idEstado=0,
    required this.edoName,
    required this.capital,
    required this.poblacion,
    
  });
  final int id;
  final int idEstado;
  final String edoName;
  final String capital;
  final String poblacion;
  

  @override
  State<EstadoDetallePage> createState() => _EstadoDetallePageState();
}

class _EstadoDetallePageState extends State<EstadoDetallePage> {
  late EstadoCubit _cubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Estado ${widget.edoName}'),
      ),
      body: BlocProvider(
        create: (context) => EstadoCubit()..init(idEstado: widget.idEstado),
        child: BlocBuilder<EstadoCubit, EstadoState>(
          builder: (context, state) {
            _cubit = context.read<EstadoCubit>();
            
            
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child:  Text(
                        'Datos del Estado',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox( height: 10,),
                    Text(
                      'Nombre: ${widget.edoName}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox( height: 10,),
                    Text(
                      'Capital: ${widget.capital}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox( height: 10,),
                    Text(
                      'Poblacion: ${widget.poblacion}',
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
  final controllerEdoName = TextEditingController();
  final controllerCapital = TextEditingController();
  final controllerPoblacion = TextEditingController();
  
  Widget formUpdateLibro(int id){
    String edoName, capital, poblacion;
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Nombre del estado',
          ),
          controller: controllerEdoName,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Capital del estado',
          ),
          controller: controllerCapital,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Poblacion del estado',
          ),
          controller: controllerPoblacion,
        ),
        
        const SizedBox( height: 10,),
        ElevatedButton(
          onPressed: () {
            if(controllerEdoName.text.isEmpty){
              edoName = widget.edoName;                                          
            } else{
              edoName = controllerEdoName.text;                          
            }
            
            if(controllerCapital.text.isEmpty){
              capital = widget.capital;
            }else{
              capital = controllerCapital.text;
            }
            if(controllerPoblacion.text.isEmpty){
              poblacion = widget.poblacion;
            }else{
              poblacion = controllerPoblacion.text;
            }
            _cubit.update(
              id: id,
              edoName: edoName, 
              capital: capital, 
              poblacion: poblacion, 
              
              context: context,
            );
            controllerCapital.clear();
            controllerPoblacion.clear();
            controllerEdoName.clear();
            
          }, 
          child: const Text('Editar'),
        )
      ],
    );
  }
}
