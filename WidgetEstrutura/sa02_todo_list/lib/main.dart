// Situação de aprendizagem 02 - aplicativo todo list

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: TodoListView()));
}

//Classe da janela statefull
//1° classe: identifica as mudanças de estado e chama o rebuild da tela
class TodoListView extends StatefulWidget {
  const TodoListView({super.key});

  //Chama o rebuild
  @override
  State<TodoListView> createState() => _TodoListViewState(); //Arrow function
}

// 2° classe: fica a lógica da tela, o que vai ser exibido, os widgets, etc
class _TodoListViewState extends State<TodoListView> {
  //Atributos
  //OBJ para controlar o campo de texto (Input)
  //final => Permite a mudança de valor uma única vez, ou seja, o objeto pode ser modificado, mas não pode ser reatribuído a outro valor
  //_ O uso do underline, transforma a variável em privada, ou seja, só pode ser acessada dentro da classe onde foi declarada
  final TextEditingController _tarefasController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final List<Map<String, dynamic>> _tarefas =
      []; //Lista de tarefas, onde cada tarefa é representada por uma coleção [{}] com chaves e valores (Map)

  //Métodos

  //Build => logica por tras da construção da tela, o que vai ser exibido, etc
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Tarefas"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(8), //Espaçamento geral de 8px,
        child: Column(
          children: [
            //Adicionar +1 elemento
            TextField(
              controller: _tarefasController,
              decoration: InputDecoration(labelText: "Digite uma Tarefa..."),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: "Digite uma Descrição..."),
            ),
            SizedBox(height: 20), //Espaçamento entre o campo de texto e o botão
            ElevatedButton(
              onPressed: _adicionarTarefa,
              child: Text("Adicionar"),
            ),
            //Lisatr as tarefas da lista
            //scroll de parte da tela
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder:
                    (context, index) => //Para cada elemento (ForEach)
                    ListTile(
                      title: Text(
                        _tarefas[index]['titulo'],
                        style: TextStyle(
                          decoration: _tarefas[index]['concluida']
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      subtitle: Text(_tarefas[index]['descricao']),
                      //Adicionar um checkbox antes do texto
                      leading: Checkbox(
                        value: _tarefas[index]["concluida"],
                        onChanged: (bool? valor) => setState(() {
                          _tarefas[index]["concluida"] =
                              valor!; //Inverte o valor da booleana
                        }),
                      ),
                      //Adicionar icone para deletar tarefa
                      trailing: IconButton(
                        onPressed: () => _deletartarefa(index),
                        icon: Icon(Icons.delete),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Método para adicionar uma tarefa à lista
  void _adicionarTarefa() {
    if (_tarefasController.text.trim().isNotEmpty) {
      // se tarefa nãp estiver vazia
      //adiciona a tarefa a lista
      //mudar o estado da janela
      setState(() {
        // envia um aviso da mudança de estado
        _tarefas.add({
          "titulo": _tarefasController.text.trim(),
          "descricao": _descricaoController.text.trim(),
          "concluida": false,
        });
      });
      _tarefasController.clear();
      _descricaoController.clear();
    }
  }

  //TODO: metodo para deletar tarefa (Apenas se estiver preenchida)

  void _deletartarefa(int index) {
    if (_tarefas[index]["concluida"] == true) {
      setState(() {
        _tarefas.removeAt(index);
      });
    }
  }
}
