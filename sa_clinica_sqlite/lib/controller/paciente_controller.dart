import 'package:sa_clinica_sqlite/database/db_helper.dart';
import 'package:sa_clinica_sqlite/model/paciente.dart';

class PacienteController {
  //estabelecer as conexões com o db
  final _dbHelper = DatabaseHelper();

  // métodos do controller

  Future<int> salvarPaciente(Paciente paciente) async {
    return _dbHelper.insertPaciente(paciente);
  }

  Future<List<Paciente>> listarPacientes() async => _dbHelper.getPacientes();
}
