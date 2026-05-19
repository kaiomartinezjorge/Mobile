class Tarefa {
  //Atributos
  String titulo; // Atribui o titulo a tarefa
  bool concluida; // Atribui o status da tarefa
  DateTime criadaEm = DateTime.now(); // Atribui a data da tarefa

  //construtor
  // required == é obrigatorio
  Tarefa({required this.titulo, this.concluida = false, DateTime? criadaEm}) {
    if (criadaEm != null) {
      this.criadaEm = criadaEm;
    }
  }
}
