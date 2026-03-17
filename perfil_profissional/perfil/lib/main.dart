import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Perfil());
  }
}

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // BARRA SUPERIOR
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Meu perfil"),
        actions: [Icon(Icons.share)],
      ),

      body: Column(
        children: [
          // AREA DO PERFIL
          Container(
            color: Colors.grey[300],
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),

                SizedBox(width: 20),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Kaio Martinez Jorge", style: TextStyle(fontSize: 18)),
                    Text("kaiomartinez831@gmail.com"),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // SEGUIDORES / SEGUINDO / POSTS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 100,
                height: 70,
                color: Colors.green[900],
                child: Center(
                  child: Text(
                    "Seguidores",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              Container(
                width: 100,
                height: 70,
                color: Colors.green[900],
                child: Center(
                  child: Text(
                    "Seguindo",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              Container(
                width: 100,
                height: 70,
                color: Colors.green[900],
                child: Center(
                  child: Text("Posts", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),

          SizedBox(height: 30),

          // ICONES
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.camera_alt, size: 30),
              Icon(Icons.business, size: 30),
              Icon(Icons.code, size: 30),
              Icon(Icons.phone, size: 30),
            ],
          ),

          SizedBox(height: 30),

          // LISTA
          ListTile(
            title: Text("Habilidades"),
            trailing: Icon(Icons.arrow_upward),
          ),

          ListTile(
            title: Text("Localização"),
            trailing: Icon(Icons.arrow_upward),
          ),

          ListTile(title: Text("Carreira"), trailing: Icon(Icons.arrow_upward)),

          ListTile(
            title: Text("Habilidades"),
            trailing: Icon(Icons.arrow_upward),
          ),

          ListTile(
            title: Text("Habilidades"),
            trailing: Icon(Icons.arrow_upward),
          ),
        ],
      ),

      // MENU INFERIOR
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}
