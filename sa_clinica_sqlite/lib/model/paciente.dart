class Paciente {
  int? id; // Pode ser nulo inicialmente.
  String nome;
  String cpf;
  DateTime dataNascimento;
  String email;
  String telefone;
  String historicoMedico;

  Paciente({
    this.id,
    required this.nome,
    required this.cpf,
    required this.dataNascimento,
    required this.email,
    required this.telefone,
    required this.historicoMedico,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'dataNascimento': dataNascimento.toIso8601String(),
      'email': email,
      'telefone': telefone,
      'historicoMedico': historicoMedico,
    };
  }

  factory Paciente.fromMap(Map<String, dynamic> map) {
    return Paciente(
      id: map['id'],
      nome: map['nome'],
      cpf: map['cpf'],
      dataNascimento: DateTime.parse(map['dataNascimento']),
      email: map['email'] ?? '',
      telefone: map['telefone'],
      historicoMedico: map['historicoMedico'] ?? '',
    );
  }
}
