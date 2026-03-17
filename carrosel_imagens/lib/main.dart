//Situação de Aprendizagem 01 - Carrossel de Imagens no Flutter (Stateless)
//Usar uma lista de imagens para montar um carrossel no flutter
// Flutter pub add carousel_slider (Biblioteca do Flutter Pub Get)

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false, // Remover a flag do debug
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  //Remover o const
  //Para usar a lista de imagens
  MyApp({super.key});

  //Lista de Imagens(Array)
  List<String> imagens = [
    "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0",
    "https://images.unsplash.com/photo-1521747116042-5a810fda9664",
    "https://images.unsplash.com/photo-1504384308090-c894fdcc538d",
    "https://images.unsplash.com/photo-1518837695005-2083093ee35b",
    "https://images.unsplash.com/photo-1501594907352-04cda38ebc29",
    "https://images.unsplash.com/photo-1519681393784-d120267933ba",
    "https://images.unsplash.com/photo-1531259683007-016a7b628fc3",
    "https://images.unsplash.com/photo-1506619216599-9d16d0903dfd",
    "https://images.unsplash.com/photo-1494172961521-33799ddd43a5",
    "https://images.unsplash.com/photo-1517245386807-bb43f82c33c4",
  ];

  //Build da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Galeria de Imagens"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            //Carrossel de imagens da Galeria
            CarouselSlider(
              options: CarouselOptions(
                height: 300, //Altura máxima do carrossel
                autoPlay: true, //Pre-definição de scroll do carrossel
              ),
              items: imagens
                  .map(
                    //percorrer a lista
                    ((url) => Container(
                      margin: EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                          width: 1000,
                        ),
                      ),
                    )),
                  )
                  .toList(),
            ),
            //Galeria de Imagens
            Expanded(
              child: GridView.builder(
                //como vou montar o grid (Layout do Grid)
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //número de colunas
                  crossAxisSpacing: 8, //espaçamento entre colunas
                  mainAxisSpacing: 8, //espaçamento entre linhas
                ),
                itemCount: imagens
                    .length, // quantidade de elementos da lista é a quantidade de elementos do grid
                //construtor do grid
                //construindo usando um foreach
                itemBuilder:
                    (context, index) => //arrow function
                    GestureDetector(
                      onTap: () => _mostrarImagem(
                        context,
                        index,
                      ), //método para mostrar a imagem no detalhe
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(imagens[index], fit: BoxFit.cover),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarImagem(BuildContext context, int index) {
    //imagen => endereço URL da Imagem
    //mpostrar imagens com mais detalhe ao ser clicada,
    //precisa do index da imagem para buscar no array
    //showDialog => Mostrar a imagem
    showDialog(
      context: context, // contexto da tela
      builder: (context) => Dialog(child: Image.network(imagens[index])),
    );
  }
}
