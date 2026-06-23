import 'package:path/path.dart';
import 'package:sa_clinica_sqlite/model/atendimento.dart';
import 'package:sa_clinica_sqlite/model/paciente.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), "clinica_odontologica.db");

    return openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      },
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE pacientes(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT NOT NULL,
          cpf TEXT NOT NULL UNIQUE,
          dataNascimento TEXT NOT NULL,
          email TEXT,
          telefone TEXT NOT NULL,
          historicoMedico TEXT)''');

        await db.execute('''CREATE TABLE atendimentos(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          paciente_id INTEGER,
          data TEXT NOT NULL,
          hora TEXT NOT NULL,
          descricao_procedimento TEXT NOT NULL,
          dentes_envolvidos TEXT,
          observacoes TEXT,
          valor_cobrado REAL NOT NULL,
          FOREIGN KEY(paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE)''');
      },
    );
  }

  Future<int> insertPaciente(Paciente paciente) async {
    return (await database).insert("pacientes", paciente.toMap());
  }

  Future<int> updatePaciente(Paciente paciente) async {
    return (await database).update(
      "pacientes",
      paciente.toMap(),
      where: "id = ?",
      whereArgs: [paciente.id],
    );
  }

  Future<int> deletePaciente(int id) async {
    return (await database).delete(
      "pacientes",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<Paciente?> getPacientePorCpf(String cpf) async {
    final maps = await (await database).query(
      "pacientes",
      where: "cpf = ?",
      whereArgs: [cpf],
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return Paciente.fromMap(maps.first);
  }

  Future<Paciente?> getPacientePorId(int id) async {
    final maps = await (await database).query(
      "pacientes",
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return Paciente.fromMap(maps.first);
  }

  Future<List<Paciente>> getPacientes() async {
    final maps = await (await database).query(
      "pacientes",
      orderBy: "nome ASC",
    );

    return List.generate(maps.length, (e) => Paciente.fromMap(maps[e]));
  }

  Future<int> insertAtendimento(Atendimento atendimento) async {
    return (await database).insert("atendimentos", atendimento.toMap());
  }

  Future<int> updateAtendimento(Atendimento atendimento) async {
    return (await database).update(
      "atendimentos",
      atendimento.toMap(),
      where: "id = ?",
      whereArgs: [atendimento.id],
    );
  }

  Future<int> deleteAtendimento(int id) async {
    return (await database).delete(
      "atendimentos",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<List<Atendimento>> getAtendimentosPorPaciente(int pacienteId) async {
    final maps = await (await database).query(
      "atendimentos",
      where: "paciente_id = ?",
      whereArgs: [pacienteId],
      orderBy: "data ASC, hora ASC",
    );

    return List.generate(maps.length, (e) => Atendimento.fromMap(maps[e]));
  }
}
