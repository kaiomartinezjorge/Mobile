import 'package:sa_clinica_sqlite/database/db_helper.dart';
import 'package:sa_clinica_sqlite/model/atendimento.dart';

class AtendimentoController {
  final _dbHelper = DatabaseHelper();

  Future<int> salvarAtendimento(Atendimento atendimento) {
    if (atendimento.id != null) {
      return _dbHelper.updateAtendimento(atendimento);
    }

    return _dbHelper.insertAtendimento(atendimento);
  }

  String getProcedimento(Atendimento atendimento) {
    return atendimento.descricaoProcedimento;
  }

  String getDataHora(Atendimento atendimento) {
    return "${atendimento.data} as ${atendimento.hora}";
  }

  Future<List<Atendimento>> listarAtendimentos(int pacienteId) {
    return _dbHelper.getAtendimentosPorPaciente(pacienteId);
  }

  Future<int> excluirAtendimento(int id) {
    return _dbHelper.deleteAtendimento(id);
  }
}
