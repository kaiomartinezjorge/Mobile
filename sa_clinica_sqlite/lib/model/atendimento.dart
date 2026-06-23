class Atendimento {
  int? id; //Pode ser nulo incialmente
  int pacienteId;
  String data;
  String hora;
  String descricaoProcedimento;
  String dentesEnvolvidos;
  String observacoes;
  double valorCobrado;

  //Construtor
  Atendimento({
    this.id,
    required this.pacienteId,
    required this.data,
    required this.hora,
    required this.descricaoProcedimento,
    required this.dentesEnvolvidos,
    required this.observacoes,
    required this.valorCobrado,
  });

  //Mapeamento de dados do BD
  //ToMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'paciente_id': pacienteId,
      'data': data,
      'hora': hora,
      'descricao_procedimento': descricaoProcedimento,
      'dentes_envolvidos': dentesEnvolvidos,
      'observacoes': observacoes,
      'valor_cobrado': valorCobrado,
    };
  }

  //FromMap
  factory Atendimento.fromMap(Map<String, dynamic> map) {
    return Atendimento(
      id: map["id"],
      pacienteId: map["paciente_id"],
      data: map["data"],
      hora: map["hora"],
      descricaoProcedimento: map["descricao_procedimento"],
      dentesEnvolvidos: map["dentes_envolvidos"] ?? '',
      observacoes: map["observacoes"] ?? '',
      valorCobrado: (map["valor_cobrado"] as num).toDouble(),
    );
  }
}
