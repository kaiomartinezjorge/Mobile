import 'package:sa_petshop_sqlite/database/database_helper.dart';
import 'package:sa_petshop_sqlite/model/consulta.dart';

class ConsultaController {
  final _dbHelper = DatabaseHelper();

  Future<int> salvarConsulta(Consulta consulta) {
    return _dbHelper.insertConsulta(consulta);
  }

  Future<List<Consulta>> listarConsultas(int petId) =>
      _dbHelper.getConsultasPorPet(petId);
}
