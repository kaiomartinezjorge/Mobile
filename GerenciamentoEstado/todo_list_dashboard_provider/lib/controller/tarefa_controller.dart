//controller vai ter a função de provider

import 'package:flutter/material.dart';
import 'package:todo_list_dashboard_provider/model/tarefa.dart';

class TarefaController extends ChangeNotifier {
  // tranformo a classe controller em herdeira da changeNotifier (Provider)
  //Classe que vai armazenar
  final List<Tarefa> _tarefas =
      []; //array que vai aramazenar as tarefas criadas ( obj da classe model)
  // obs: _ => atributo privado

  //Liberar o Acesso (getter)
  List<Tarefa> get tarefas => _tarefas;

  //Métodos (CRUD)
  //Create
  void createTarefa(String titulo) {
    if (titulo.trim().isEmpty) {
      return; //Se o titulo estiver vazio, interrompe o métodos
    }

    _tarefas.add(Tarefa(titulo: titulo)); //Adicionar um obj de Tarefa ao Vetor

    notifyListeners(); //Avisar ao listeners que foi adicionado uma tarefa no vetor
  }

  //UPDATE
  void updateTarefa(int index) {
    _tarefas[index].concluida = !_tarefas[index].concluida;
    notifyListeners();
  }

  //DELETE
  void deleteTarefa(int index) {
    _tarefas.removeAt(index);
    notifyListeners();
  }

  //Criar métodos para definição das métricas
  // TotalTarefas => calcula no nº total de Tarefas
  int get totalTarefas => _tarefas.length;

  //TotalTarefasConcluidas
  int get totalTarefasConcluidas =>
      _tarefas.where((tarefa) => tarefa.concluida).length;

  //TotalTarefasPendentes
  int get totalTarefasPendentes =>
      _tarefas.where((tarefa) => !tarefa.concluida).length;

  //porcentagemTarefasConcluidas
  double get porcentagemTarefasConcluidas {
    if (totalTarefas == 0) return 0;
    return totalTarefasConcluidas / totalTarefas * 100;
  }
}
