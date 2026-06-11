import 'package:flutter/material.dart';
import 'package:sa_clinica_sqlite/controller/atendimento_controller.dart';
import 'package:sa_clinica_sqlite/controller/paciente_controller.dart';
import 'package:sa_clinica_sqlite/model/atendimento.dart';
import 'package:sa_clinica_sqlite/model/paciente.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PacienteController _controller = PacienteController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Clinica - Lista de Pacientes")),
      body: FutureBuilder<List<Paciente>>(
        future: _controller.listarPacientes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final pacientes = snapshot.data!;
          return ListView.builder(
            itemCount: pacientes.length,
            itemBuilder: (context, i) => ListTile(
              leading: Icon(Icons.person),
              title: Text(pacientes[i].nome),
              subtitle: Text(pacientes[i].email),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => PacienteDetailScreen(paciente: pacientes[i]),
                ),
              ).then((value) => setState(() {})),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (c) => AddPacienteScreen()),
        ).then((value) => setState(() {})),
      ),
    );
  }
}
