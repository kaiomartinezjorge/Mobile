//Uso de Elementos de Interação ( TextField, ElevatedButton, CheckBox, Slider)
import 'package:flutter/material.dart';

import 'pages/contato_page.dart';
import 'pages/form_page.dart';
import 'pages/home_page.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      //Sistema de rotas oara navegação entre telas
      //Home(Tela inicial), Form: (Tela de formulário), Contato(Tela de contato)
      routes: {
        "/": (context) => HomePage(),
        "/form": (context) => FormPage(),
        "/contato": (context) => ContatoPage(),
      },
      //Direcionar o aplicativo qunado iniciar para a home
      initialRoute: "/",
    ),
  );
}

//Página main finalizada
