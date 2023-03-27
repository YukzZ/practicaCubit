

import 'package:flutter/material.dart';
import 'package:flutter_app/data/model/libreria_model.dart';
import 'package:flutter_app/modules/estado/cubit/estado_cubit.dart';
import 'package:flutter_app/modules/estado/view/estado_detalle_page.dart';
import 'package:flutter_app/modules/libreria/view/libreria_detalle_page.dart';
import 'package:flutter_app/modules/libreria/view/libreria_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EstadoPage extends StatefulWidget {
  const EstadoPage({super.key});

  @override
  State<EstadoPage> createState() => _EstadoPageState();
}

class _EstadoPageState extends State<EstadoPage> {
  late EstadoCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estado'),),
      body: BlocProvider(
        create: (context) => EstadoCubit()..getAll(),
        child: BlocBuilder<EstadoCubit, EstadoState>(
            builder: (context, state) {
              cubit = context.read<EstadoCubit>();
              Widget child = const Center(child: Text('No hay datos'),);
              if(state.status == EstadoEstatus.success){
                child = ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: state.lsEstados.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        await Navigator.push<void>(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => LibreriaPage(
                              idEstado: state.lsEstados[index].id,
                            ),
                          ),
                        ).then((value) => cubit.getAll());
                      },
                      child: Column(
                        children: [
                          ListTile(
                            leading: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255, 231, 76, 60,
                              ),
                              
                              ),
                                onPressed: () {
                                  cubit.delete(
                                    libroModel: state.lsEstados[index].id, 
                                    context: context,
                                  );
                                }, 
                                child: const Icon(Icons.remove),
                              ),
                              trailing: ElevatedButton(
                                onPressed: () async {
                                  await Navigator.push(
                                    context, 
                                    MaterialPageRoute<void>(
                                      builder: (context) => EstadoDetallePage(
                                        id: state.lsEstados[index].id,
                                        edoName: state.lsEstados[index].edoName, 
                                        capital: state.lsEstados[index].capital, 
                                        poblacion: state.lsEstados[index].poblacion,
                                      ),
                                    ),
                                  );
                                },
                                child: const Icon(Icons.add),
                              ),
                            title: Text(state.lsEstados[index].edoName),
                          ),
                          listLibrerias(
                            lsLibrerias: state.lsEstados[index].lsLibreria,
                            id: state.lsEstados[index].id,
                          ),
                        ],
                      ),
                      
                    );
                  },
                );
              } else if (state.status == EstadoEstatus.loading) {
              child = const Center(child: CircularProgressIndicator());
              } else {
              child = const Center(child: Text('No hay datos'));
            }
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                formNuevoEstado(cubit: cubit),
                Expanded(child: child),
              ],),
            );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          cubit.getAll();
        },
        child: const Icon(Icons.refresh, color: Colors.white,),
        ),
    );
  }

  Widget listLibrerias({
    required List<LibreriaModel> lsLibrerias, 
    required int id,
  }){
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Card(
            color: Colors.grey,
            child: InkWell(
              onTap: () async{
                await Navigator.push(
                          context, 
                          MaterialPageRoute<void>(
                            builder: (context) => LibreriaDetallePage(
                              id: lsLibrerias[index].id,
                              idEstado: id,
                              libName: lsLibrerias[index].libName,
                              correo: lsLibrerias[index].correo,
                              direccion: lsLibrerias[index].direccion,
                              telefono: lsLibrerias[index].telefono,
                            ),
                          ),
                        );
              },
              child: ListTile(
                
                title: Text(
                  lsLibrerias[index].libName,
                ),
              ),
            ),
          ),
        );
      },
      itemCount: lsLibrerias.length,
    );
  }

  final controllerNombre = TextEditingController();
  final controllerCapital = TextEditingController();
  final controllerPoblacion = TextEditingController();
  Widget formNuevoEstado({required EstadoCubit cubit}){
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Nombre',
          ),
          controller: controllerNombre,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Capital',
          ),
          controller: controllerCapital,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Poblacion',
          ),
          controller: controllerPoblacion,
        ),
        ElevatedButton(onPressed: () {
          cubit.save(
            capital: controllerCapital.text, 
            edoName: controllerNombre.text, 
            poblacion: controllerPoblacion.text,
          );
          controllerCapital.clear();
          controllerNombre.clear();
          controllerPoblacion.clear();
        }, child: const Text('Guardar'),)
      ],
    );
  }
  

}
