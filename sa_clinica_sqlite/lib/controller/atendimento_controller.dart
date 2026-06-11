import 'package:sa_clinica_sqlite/database/db_helper.dart';
import 'package:sa_clinica_sqlite/model/atendimento.dart';

class AtendimentoController {
  final _dbHelper = DatabaseHelper();

  Future<int> salvarAtendimento(Atendimento atendimento) {
    return _dbHelper.insertAtendimento(atendimento);
  }

  String getProcedimento(Atendimento atendimento) =>
      atendimento.descricaoProcedimento;

  String getDataHora(Atendimento atendimento) => atendimento.dataAtendimento;

  Future<List<Atendimento>> listarAtendimentos(int pacienteId) =>
      _dbHelper.getAtendimentosPorPaciente(pacienteId);
}
