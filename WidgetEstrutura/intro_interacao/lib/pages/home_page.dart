//Tela inicial
//Vai ter botões de navegação para as outras telas

import 'package:flutter/material.dart';
import 'package:intro_interacao/Widgets/bnb.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meu aplicativo Interativo")),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://static.wikia.nocookie.net/futebol/images/3/39/S%C3%A3o_Paulo_2005.png/revision/latest/thumbnail/width/360/height/360?cb=20251226203200",
                width: 300,
                height: 300,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/form"),
                child: Text("Responder formulario"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/contato"),
                child: Text("Entre em Contato"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Bnb(context),
    );
  }
}
