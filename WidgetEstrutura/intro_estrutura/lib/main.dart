//Criar o void main
//Responsavel por rodar o elemento principal da aplicação

import 'package:flutter/material.dart';

void main() {
  //runapp => chama o elemento material app
  runApp(MainApp());
}

//Criar a classe MainApp
class MainApp extends StatelessWidget {
  const MainApp({super.key});
  //Construto da Tela estatica
  @override
  Widget build(BuildContext context) {
    //Montar a estrutura do MaterialApp
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Tela de login")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: //Permite mais de 1 abre colchetes
            [
              //Elementos de input de texto
              Text("E-mail"),
              TextField(textAlign: TextAlign.center),
              Text("Senha"),
              TextField(textAlign: TextAlign.center, obscureText: true),
              TextButton(onPressed: () {}, child: Text("Enviar")),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items:
              //permite mais de 1, abre colchetes
              [
                BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_back),
                  label: "back",
                ),
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_forward),
                  label: "forward",
                ),
              ],
        ),
      ),
    );
  }
}
