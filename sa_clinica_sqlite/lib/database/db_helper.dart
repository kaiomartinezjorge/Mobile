import 'package:path/path.dart';
import 'package:sa_clinica_sqlite/model/atendimento.dart';
import 'package:sa_clinica_sqlite/model/paciente.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //Transforma essa classe em singleton
  //não permite instanciar outro obj enquanto um obj estiver ativo
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  //Construir o Singleton
  // essa Classe não Possui um Construtor Normal,
  //ele Precisa do factory para estabelecer a conexão
  DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  //Conector do Banco de Dados
  Database? _database; //Privado

  //get database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    //pegar o armazenamento do banco
    String path = join(await getDatabasesPath(), "petshop.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE pacientes(
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          nome TEXT, 
          email TEXT, 
          telefone TEXT)''');
        await db.execute(
          '''CREATE TABLE atendimentos(
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          paciente_id INTEGER, 
          dataAtendimento TEXT, 
          descricao_procedimento TEXT, 
          observacoes TEXT,
          FOREIGN KEY(paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE)''',
        );
      },
      onConfigure: (db) async =>
          await db.execute("PRAGMA foreign_keys = ON"), //delete on CASCADE
    );
  }

  //Métodos CRUD Simplificados
  //inserir paciente no BD
  Future<int> insertPaciente(Paciente paciente) async =>
      (await database).insert("pacientes", paciente.toMap());

  // Listar Pacientes do BD
  Future<List<Paciente>> getPacientes() async {
    final List<Map<String, dynamic>> maps = await (await database).query(
      "pacientes",
      orderBy: "nome ASC",
    );
    return List.generate(maps.length, (e) => Paciente.fromMap(maps[e]));
  }

  //InsertAtendimento
  Future<int> insertAtendimento(Atendimento a) async =>
      (await database).insert("atendimentos", a.toMap());

  //Get Atendimentos por Paciente
  Future<List<Atendimento>> getAtendimentosPorPaciente(int pacienteId) async {
    final List<Map<String, dynamic>> maps = await (await database).query(
      "atendimentos",
      where: "paciente_id = ?",
      whereArgs: [pacienteId],
      orderBy: "dataAtendimento DESC",
    );
    return List.generate(maps.length, (e) => Atendimento.fromMap(maps[e]));
  }
}
