class Atendimento {
  int? id; //Pode ser nulo incialmente
  int pacienteId;
  String dataAtendimento;
  String descricaoProcedimento;
  String observacoes;
  String valor;

  //Construtor
  Atendimento({
    this.id,
    required this.pacienteId,
    required this.dataAtendimento,
    required this.descricaoProcedimento,
    required this.observacoes,
    required this.valor,
  });

  //Mapeamento de dados do BD
  //ToMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'paciente_id': pacienteId,
      'dataAtendimento': dataAtendimento,
      'descricao_procedimento': descricaoProcedimento,
      'observacoes': observacoes,
      'valor': valor,
    };
  }

  //FromMap
  factory Atendimento.fromMap(Map<String, dynamic> map) {
    return Atendimento(
      id: map["id"],
      pacienteId: map["paciente_id"],
      dataAtendimento: map["dataAtendimento"],
      descricaoProcedimento: map["descricao_procedimento"],
      observacoes: map["observacoes"],
      valor: map["valor"],
    );
  }
}
