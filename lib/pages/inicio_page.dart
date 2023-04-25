import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:transporte/pages/login_page.dart';
import 'package:transporte/pages/rutas_page.dart';
import 'package:transporte/services/ruta_servive.dart';
import 'package:transporte/widgets/cards.dart';


class InicioPage extends StatelessWidget {
  const InicioPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardInicio(
              navegator: () async{
                final rutaService = Provider.of<RutaService>(context, listen: false);
                final ruta = await rutaService.getRutasDisponibles();
                ruta.isEmpty ? 
                Get.to(RutaPage()) : Get.to(RutaPage(rutas: ruta,));
              },
              image: 'assets/transporte.png', titulo: 'Rutas',ancho: 0.5),
            CardInicio(navegator: () => Get.to(LoginPage()), image: 'assets/login.png', titulo: 'Login', ancho: 0.5),
          ],
        ),
      )
   );
  }
}