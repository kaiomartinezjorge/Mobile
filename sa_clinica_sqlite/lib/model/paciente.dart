class Paciente {
  int? id; // Pode ser nulo inicialmente.
  String nome;
  String cpf;
  DateTime dataNascimento;
  String email;
  String telefone;
  String procedimento;

  Paciente({
    this.id,
    required this.nome,
    required this.cpf,
    required this.dataNascimento,
    required this.email,
    required this.telefone,
    required this.procedimento,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'CPF': cpf,
      'dataNascimento': dataNascimento.toIso8601String(),
      'email': email,
      'telefone': telefone,
      'procedimento': procedimento,
    };
  }

  factory Paciente.fromMap(Map<String, dynamic> map) {
    return Paciente(
      id: map['id'],
      nome: map['nome'],
      cpf: map['CPF'],
      dataNascimento: DateTime.parse(map['dataNascimento']),
      email: map['email'],
      telefone: map['telefone'],
      procedimento: map['procedimento'],
    );
  }
}
