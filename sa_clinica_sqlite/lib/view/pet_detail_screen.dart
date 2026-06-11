import 'package:flutter/material.dart';
import 'package:sa_clinica_sqlite/database/db_helper.dart';
import 'package:sa_clinica_sqlite/model/atendimento.dart';
import 'package:sa_clinica_sqlite/controller/atendimento_controller.dart';
import 'package:sa_clinica_sqlite/model/paciente.dart';

class PacienteDetailScreen extends StatefulWidget {
  final Paciente paciente; // sera importado da tela anterior o obj PACIENTE
  const PacienteDetailScreen({super.key, required this.paciente});

  @override
  State<PacienteDetailScreen> createState() => _PacienteDetailScreenState();
}

class _PacienteDetailScreenState extends State<PacienteDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Perfil: ${widget.paciente.nome}")),
      body: Column(
        children: [
          ListTile(
            title: Text("Nome: ${widget.paciente.nome}"),
            subtitle: Text("Email: ${widget.paciente.email}"),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "Histórico de Consultas",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Atendimento>>(
              future: db_helper().getAtendimentosPorPaciente(widget.paciente.id!),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                final consultas = snapshot.data!;
                return ListView.builder(
                  itemCount: consultas.length,
                  itemBuilder: (context, i) => Card(
                    child: ListTile(
                      title: Text(AtendimentoController().getProcedimento(consultas[i])),
                      subtitle: Text(AtendimentoController().getDataHora(consultas[i])),
                      trailing: Icon(Icons.calendar_today),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Agendar"),
        icon: Icon(Icons.add_task),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (c) => AddConsultaScreen(paciente: widget.paciente)),
        ).then((value) => setState(() {})),
      ),
    );
  }
