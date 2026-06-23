import 'package:sa_clinica_sqlite/database/db_helper.dart';
import 'package:sa_clinica_sqlite/model/paciente.dart';

class PacienteController {
  final _dbHelper = DatabaseHelper();

  Future<int> salvarPaciente(Paciente paciente) async {
    final pacienteExistente = await _dbHelper.getPacientePorCpf(paciente.cpf);
    if (pacienteExistente != null && pacienteExistente.id != paciente.id) {
      throw Exception("CPF ja cadastrado");
    }

    if (paciente.id != null) {
      return _dbHelper.updatePaciente(paciente);
    }

    return _dbHelper.insertPaciente(paciente);
  }

  Future<List<Paciente>> listarPacientes() async => _dbHelper.getPacientes();

  Future<Paciente?> buscarPacientePorId(int id) async {
    return _dbHelper.getPacientePorId(id);
  }

  Future<int> excluirPaciente(int id) async => _dbHelper.deletePaciente(id);
}
