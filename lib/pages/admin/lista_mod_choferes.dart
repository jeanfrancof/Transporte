import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:transporte/pages/admin/modificar_chofer.dart';
import 'package:transporte/services/auth_service.dart';
import 'package:transporte/services/user_service.dart';
import '../../models/user_model.dart';



class ListaModChoferes extends StatelessWidget {
  const ListaModChoferes({super.key, required this.choferes,});
  
  final  List<Users> choferes;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Modificar Choferes'),
            centerTitle: true,
          ),
          body: Container(
            margin: EdgeInsets.symmetric(vertical: size.height * 0.04),
            width: double.infinity,
            height: double.infinity,
            child: ListView.builder(
              itemCount: choferes.length,
              itemBuilder: (context, index) {

                final chofer = choferes[index];

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: size.height * 0.01),
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: size.height * 0.012),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                     boxShadow: const[
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 5),
                        blurRadius: 5
                      )
                    ]
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person, color: Colors.blue, size: 50,),
                          const SizedBox(width: 8,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _TextCard(type: 'Nombre:', dato: chofer.nombre,),
                              _TextCard(type: 'Correo:', dato: chofer.correo,),
                              _TextCard(type: 'Identificación:', dato: chofer.identificacion,),
                              _TextCard(type: 'Telefono:', dato: chofer.telefono,),
                              _TextCard(type: 'Placa:', dato: chofer.placa,),
                              SizedBox(
                                width: size.width * 0.6,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red,),
                                      onPressed: () async{
                                        final userService = Provider.of<UserService>(context, listen: false);
                                        final authService = Provider.of<AuthService>(context, listen: false);
                                        await authService.deleteUser(chofer.correo, chofer.password!);
                                        final paso = await userService.deleteUser(chofer);
                                        if(paso){
                                          Get.back();
                                          QuickAlert.show(context: context,
                                            type: QuickAlertType.confirm,
                                            title: 'Ok',
                                            text: 'Chofer eliminado con exito'
                                          );
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.create_outlined, color: Colors.blue,),
                                      onPressed: () {
                                        Get.to(ModificarChofer(chofer: chofer,));
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }
    );
  }
}

class _TextCard extends StatelessWidget {
  const _TextCard({
    Key? key, required this.type, required this.dato,
  }) : super(key: key);

  final String type;
  final String dato;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.006),
      child: Row(
        children: [
          Text('${type} ', style: const TextStyle( fontWeight: FontWeight.bold),),
          Text(dato, style: const TextStyle( fontWeight: FontWeight.normal),),        
        ],
      ),
    );
  }
}