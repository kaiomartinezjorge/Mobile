import 'package:flutter/material.dart';
import 'package:sa_clinica_sqlite/controller/atendimento_controller.dart';
import 'package:sa_clinica_sqlite/controller/paciente_controller.dart';
import 'package:sa_clinica_sqlite/model/atendimento.dart';
import 'package:sa_clinica_sqlite/model/paciente.dart';
import 'package:sa_clinica_sqlite/view/atendimento_form_screen.dart';
import 'package:sa_clinica_sqlite/view/paciente_form_screen.dart';

class PacienteDetailScreen extends StatefulWidget {
  final Paciente paciente;

  const PacienteDetailScreen({super.key, required this.paciente});

  @override
  State<PacienteDetailScreen> createState() => _PacienteDetailScreenState();
}

class _PacienteDetailScreenState extends State<PacienteDetailScreen> {
  final _pacienteController = PacienteController();
  final _atendimentoController = AtendimentoController();
  late Paciente _paciente;

  @override
  void initState() {
    super.initState();
    _paciente = widget.paciente;
  }

  Future<void> _recarregarPaciente() async {
    final id = _paciente.id;
    if (id == null) return;

    final pacienteAtualizado = await _pacienteController.buscarPacientePorId(id);
    if (pacienteAtualizado != null && mounted) {
      setState(() => _paciente = pacienteAtualizado);
    }
  }

  Future<void> _editarPaciente() async {
    final alterou = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (c) => PacienteFormScreen(paciente: _paciente),
      ),
    );

    if (alterou == true) await _recarregarPaciente();
  }

  Future<void> _confirmarExclusaoPaciente() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Excluir paciente"),
        content: Text(
          "Deseja excluir ${_paciente.nome}? Os atendimentos tambem serao removidos.",
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

    if (confirmar != true || _paciente.id == null) return;

    try {
      await _pacienteController.excluirPaciente(_paciente.id!);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Paciente excluido com sucesso.")),
      );
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao excluir paciente: $e")),
      );
    }
  }

  Future<void> _abrirFormularioAtendimento({Atendimento? atendimento}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (c) => AtendimentoFormScreen(
          paciente: _paciente,
          atendimento: atendimento,
        ),
      ),
    );

    if (mounted) setState(() {});
  }

  Future<void> _confirmarExclusaoAtendimento(Atendimento atendimento) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Excluir atendimento"),
        content: const Text("Deseja excluir este atendimento do prontuario?"),
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

    if (confirmar != true || atendimento.id == null) return;

    try {
      await _atendimentoController.excluirAtendimento(atendimento.id!);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Atendimento excluido com sucesso.")),
      );
      setState(() {});
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao excluir atendimento: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final paciente = _paciente;

    return Scaffold(
      appBar: AppBar(
        title: Text("Prontuario: ${paciente.nome}"),
        actions: [
          IconButton(
            onPressed: _editarPaciente,
            icon: const Icon(Icons.edit),
            tooltip: "Editar paciente",
          ),
          IconButton(
            onPressed: _confirmarExclusaoPaciente,
            icon: const Icon(Icons.delete),
            tooltip: "Excluir paciente",
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  paciente.nome,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text("CPF: ${paciente.cpf}"),
                Text("Nascimento: ${_formatarData(paciente.dataNascimento)}"),
                Text("Telefone: ${paciente.telefone}"),
                Text(
                  "E-mail: ${paciente.email.isEmpty ? "Nao informado" : paciente.email}",
                ),
                const SizedBox(height: 8),
                Text(
                  "Historico medico: ${paciente.historicoMedico.isEmpty ? "Nao informado" : paciente.historicoMedico}",
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Historico de Atendimentos",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Atendimento>>(
              future: _atendimentoController.listarAtendimentos(paciente.id!),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final atendimentos = snapshot.data!;
                if (atendimentos.isEmpty) {
                  return const Center(
                    child: Text("Historico de atendimentos vazio."),
                  );
                }

                return ListView.builder(
                  itemCount: atendimentos.length,
                  itemBuilder: (context, i) {
                    final atendimento = atendimentos[i];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.calendar_today),
                        title: Text(atendimento.descricaoProcedimento),
                        subtitle: Text(
                          "${atendimento.data} as ${atendimento.hora}\n"
                          "Dentes: ${atendimento.dentesEnvolvidos.isEmpty ? "Nao informado" : atendimento.dentesEnvolvidos}\n"
                          "Observacoes: ${atendimento.observacoes.isEmpty ? "Nenhuma" : atendimento.observacoes}\n"
                          "Valor: R\$ ${atendimento.valorCobrado.toStringAsFixed(2)}",
                        ),
                        isThreeLine: true,
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == "editar") {
                              _abrirFormularioAtendimento(
                                atendimento: atendimento,
                              );
                            } else if (value == "excluir") {
                              _confirmarExclusaoAtendimento(atendimento);
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
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Atendimento"),
        icon: const Icon(Icons.add_task),
        onPressed: () => _abrirFormularioAtendimento(),
      ),
    );
  }

  String _formatarData(DateTime data) {
    final dia = data.day.toString().padLeft(2, "0");
    final mes = data.month.toString().padLeft(2, "0");
    return "$dia/$mes/${data.year}";
  }
}
