import 'package:app_movil/utiles/theme.dart';
import 'package:flutter/material.dart';

class menuItems extends StatelessWidget {
  const menuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        color: ThemeAPP.of(context).primaryBackground,
      ),
      padding: EdgeInsets.all(10),
      child: 
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/inicio'); // Navegar a otra ruta
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home_rounded,
                    size: 20,
                    color: ModalRoute.of(context)?.settings.name == '/inicio'
                        ? ThemeAPP.of(context).primary
                        : ThemeAPP.of(context).secondaryText,
                  ),
                  Text(
                    "Inicio",
                    style: TextStyle(
                      fontSize: 16,
                      color: ModalRoute.of(context)?.settings.name == '/inicio'
                          ? ThemeAPP.of(context).primary
                          : ThemeAPP.of(context).secondaryText,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/ingresoQR'); // Navegar a otra ruta
              },
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.qr_code,
                  size: 20,
                  color: ModalRoute.of(context)?.settings.name == '/ingresoQR'
                      ? ThemeAPP.of(context).primary
                      : ThemeAPP.of(context).secondaryText,
                ),
                Text(
                  "Ingreso",
                  style: TextStyle(
                    fontSize: 16,
                    color: ModalRoute.of(context)?.settings.name == '/ingresoQR'
                        ? ThemeAPP.of(context).primary
                        : ThemeAPP.of(context).secondaryText,
                  ),
                ),
              ],
            ),
              ),
              GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/perfil'); // Navegar a otra ruta
              },
              child:
              Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 20,
                  color: ModalRoute.of(context)?.settings.name == '/perfil'
                      ? ThemeAPP.of(context).primary
                      : ThemeAPP.of(context).secondaryText,
                ),
                Text(
                  "Perfil",
                  style: TextStyle(
                    fontSize: 16,
                    color: ModalRoute.of(context)?.settings.name == '/perfil'
                        ? ThemeAPP.of(context).primary
                        : ThemeAPP.of(context).secondaryText,
                  ),
                ),
              ],
            ),),
          ],
        ),
    );
  }
}