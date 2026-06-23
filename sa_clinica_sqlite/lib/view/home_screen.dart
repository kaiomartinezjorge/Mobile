import 'package:flutter/material.dart';
import 'package:sa_clinica_sqlite/controller/paciente_controller.dart';
import 'package:sa_clinica_sqlite/model/paciente.dart';
import 'package:sa_clinica_sqlite/view/paciente_form_screen.dart';
import 'package:sa_clinica_sqlite/view/pet_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PacienteController _controller = PacienteController();

  Future<void> _abrirFormulario({Paciente? paciente}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (c) => PacienteFormScreen(paciente: paciente),
      ),
    );

    if (mounted) setState(() {});
  }

  Future<void> _confirmarExclusao(Paciente paciente) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Excluir paciente"),
        content: Text(
          "Deseja excluir ${paciente.nome}? Os atendimentos tambem serao removidos.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Excluir"),
          ),
        ],
      ),
    );

    if (confirmar != true || paciente.id == null) return;

    try {
      await _controller.excluirPaciente(paciente.id!);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Paciente excluido com sucesso.")),
      );
      setState(() {});
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao excluir paciente: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Clinica - Lista de Pacientes")),
      body: FutureBuilder<List<Paciente>>(
        future: _controller.listarPacientes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final pacientes = snapshot.data!;
          if (pacientes.isEmpty) {
            return const Center(child: Text("Nenhum paciente cadastrado."));
          }

          return ListView.builder(
            itemCount: pacientes.length,
            itemBuilder: (context, i) {
              final paciente = pacientes[i];

              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(paciente.nome),
                subtitle: Text("CPF: ${paciente.cpf} | Tel: ${paciente.telefone}"),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == "editar") {
                      _abrirFormulario(paciente: paciente);
                    } else if (value == "excluir") {
                      _confirmarExclusao(paciente);
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: "editar",
                      child: Text("Editar"),
                    ),
                    PopupMenuItem(
                      value: "excluir",
                      child: Text("Excluir"),
                    ),
                  ],
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => PacienteDetailScreen(paciente: paciente),
                  ),
                ).then((value) => setState(() {})),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirFormulario(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
