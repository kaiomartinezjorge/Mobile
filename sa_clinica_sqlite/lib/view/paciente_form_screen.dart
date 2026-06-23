import 'package:flutter/material.dart';
import 'package:sa_clinica_sqlite/controller/paciente_controller.dart';
import 'package:sa_clinica_sqlite/model/paciente.dart';

class PacienteFormScreen extends StatefulWidget {
  final Paciente? paciente;

  const PacienteFormScreen({super.key, this.paciente});

  @override
  State<PacienteFormScreen> createState() => _PacienteFormScreenState();
}

class _PacienteFormScreenState extends State<PacienteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = PacienteController();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _dataController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _historicoController = TextEditingController();
  bool _salvando = false;

  bool get _editando => widget.paciente != null;

  @override
  void initState() {
    super.initState();

    final paciente = widget.paciente;
    if (paciente != null) {
      _nomeController.text = paciente.nome;
      _cpfController.text = paciente.cpf;
      _dataController.text = _formatarDataBanco(paciente.dataNascimento);
      _telefoneController.text = paciente.telefone;
      _emailController.text = paciente.email;
      _historicoController.text = paciente.historicoMedico;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _dataController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    _historicoController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _salvando = true);
    try {
      final paciente = Paciente(
        id: widget.paciente?.id,
        nome: _nomeController.text.trim(),
        cpf: _cpfController.text.trim(),
        dataNascimento: DateTime.parse(_dataController.text.trim()),
        telefone: _telefoneController.text.trim(),
        email: _emailController.text.trim(),
        historicoMedico: _historicoController.text.trim(),
      );

      await _controller.salvarPaciente(paciente);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _editando
                ? "Paciente atualizado com sucesso."
                : "Paciente cadastrado com sucesso.",
          ),
        ),
      );
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    } finally {
      if (mounted) setState(() => _salvando = false);
    }
  }

  String _formatarDataBanco(DateTime data) {
    final mes = data.month.toString().padLeft(2, "0");
    final dia = data.day.toString().padLeft(2, "0");
    return "${data.year}-$mes-$dia";
  }

  String? _validarData(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return "Informe a data de nascimento";
    }

    final data = DateTime.tryParse(valor.trim());
    if (data == null) return "Use o formato AAAA-MM-DD";
    if (data.isAfter(DateTime.now())) return "A data nao pode ser futura";
    return null;
  }

  String? _validarObrigatorio(String? valor, String mensagem) {
    if (valor == null || valor.trim().isEmpty) return mensagem;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editando ? "Editar Paciente" : "Cadastrar Paciente"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: "Nome completo"),
                validator: (value) =>
                    _validarObrigatorio(value, "Informe o nome"),
              ),
              TextFormField(
                controller: _cpfController,
                decoration: const InputDecoration(labelText: "CPF"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    _validarObrigatorio(value, "Informe o CPF"),
              ),
              TextFormField(
                controller: _dataController,
                decoration: const InputDecoration(
                  labelText: "Data de nascimento",
                  hintText: "AAAA-MM-DD",
                ),
                keyboardType: TextInputType.datetime,
                validator: _validarData,
              ),
              TextFormField(
                controller: _telefoneController,
                decoration: const InputDecoration(labelText: "Telefone"),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    _validarObrigatorio(value, "Informe o telefone"),
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "E-mail"),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: _historicoController,
                decoration: const InputDecoration(
                  labelText: "Historico medico relevante",
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _salvando ? null : _salvar,
                  icon: const Icon(Icons.save),
                  label: Text(_salvando ? "Salvando..." : "Salvar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
