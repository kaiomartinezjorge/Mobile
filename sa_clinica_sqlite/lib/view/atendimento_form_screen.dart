import 'package:flutter/material.dart';
import 'package:sa_clinica_sqlite/controller/atendimento_controller.dart';
import 'package:sa_clinica_sqlite/model/atendimento.dart';
import 'package:sa_clinica_sqlite/model/paciente.dart';

class AtendimentoFormScreen extends StatefulWidget {
  final Paciente paciente;
  final Atendimento? atendimento;

  const AtendimentoFormScreen({
    super.key,
    required this.paciente,
    this.atendimento,
  });

  @override
  State<AtendimentoFormScreen> createState() => _AtendimentoFormScreenState();
}

class _AtendimentoFormScreenState extends State<AtendimentoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = AtendimentoController();
  final _dataController = TextEditingController();
  final _horaController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _dentesController = TextEditingController();
  final _observacoesController = TextEditingController();
  final _valorController = TextEditingController();
  bool _salvando = false;

  bool get _editando => widget.atendimento != null;

  @override
  void initState() {
    super.initState();

    final atendimento = widget.atendimento;
    if (atendimento != null) {
      _dataController.text = atendimento.data;
      _horaController.text = atendimento.hora;
      _descricaoController.text = atendimento.descricaoProcedimento;
      _dentesController.text = atendimento.dentesEnvolvidos;
      _observacoesController.text = atendimento.observacoes;
      _valorController.text = atendimento.valorCobrado.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _dataController.dispose();
    _horaController.dispose();
    _descricaoController.dispose();
    _dentesController.dispose();
    _observacoesController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _salvando = true);
    try {
      final atendimento = Atendimento(
        id: widget.atendimento?.id,
        pacienteId: widget.paciente.id!,
        data: _dataController.text.trim(),
        hora: _horaController.text.trim(),
        descricaoProcedimento: _descricaoController.text.trim(),
        dentesEnvolvidos: _dentesController.text.trim(),
        observacoes: _observacoesController.text.trim(),
        valorCobrado: double.parse(
          _valorController.text.trim().replaceAll(",", "."),
        ),
      );

      await _controller.salvarAtendimento(atendimento);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _editando
                ? "Atendimento atualizado com sucesso."
                : "Atendimento registrado com sucesso.",
          ),
        ),
      );
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao salvar atendimento: $e")),
      );
    } finally {
      if (mounted) setState(() => _salvando = false);
    }
  }

  String? _validarObrigatorio(String? valor, String mensagem) {
    if (valor == null || valor.trim().isEmpty) return mensagem;
    return null;
  }

  String? _validarValor(String? valor) {
    if (valor == null || valor.trim().isEmpty) return "Informe o valor";

    final valorNumerico = double.tryParse(valor.trim().replaceAll(",", "."));
    if (valorNumerico == null) return "Informe um valor numerico";
    if (valorNumerico < 0) return "O valor nao pode ser negativo";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editando ? "Editar Atendimento" : "Novo Atendimento"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.paciente.nome} - CPF: ${widget.paciente.cpf}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dataController,
                decoration: const InputDecoration(
                  labelText: "Data do atendimento",
                  hintText: "AAAA-MM-DD",
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) =>
                    _validarObrigatorio(value, "Informe a data"),
              ),
              TextFormField(
                controller: _horaController,
                decoration: const InputDecoration(
                  labelText: "Hora do atendimento",
                  hintText: "HH:MM",
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) =>
                    _validarObrigatorio(value, "Informe a hora"),
              ),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(
                  labelText: "Descricao do procedimento",
                ),
                maxLines: 3,
                validator: (value) =>
                    _validarObrigatorio(value, "Informe o procedimento"),
              ),
              TextFormField(
                controller: _dentesController,
                decoration: const InputDecoration(
                  labelText: "Dentes envolvidos",
                ),
              ),
              TextFormField(
                controller: _observacoesController,
                decoration: const InputDecoration(labelText: "Observacoes"),
                maxLines: 3,
              ),
              TextFormField(
                controller: _valorController,
                decoration: const InputDecoration(labelText: "Valor cobrado"),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: _validarValor,
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
