//Pagina de formulario
//Tela com elementos de formulario para interação do usuário
//textField
//checkBox
//radio button
//slider // barra de seleção
//switch=> botão de alternância
//dropdown => menu suspenso

//form => Ajuda na validação dos campos

import 'package:flutter/material.dart';

//Chama as mudanças de estado
class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

//Logica de construção da tela
class _FormPageState extends State<FormPage> {
  //Atributos
  String _nome = "";
  String _email = "";
  String _senha = "";
  String _confirmarSenha = "";
  bool _aceitarTermos = false; //Switch dos termos
  String _sexo = "Feminino"; //Radio (Feminino)
  double _idade = 18; //Slider (18)
  List<String> _interesses = []; //checkbox (Lista de interesses)
  String _cidade = "Americana"; //Dropdown (Lista de cidades)
  bool _obscureSenha = true;

  //Chave global de validação do fromulario
  final _formKey =
      GlobalKey<FormState>(); //Formulario so vai se enviado se for validado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Formulário de cadastro")),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey, //Chave de validação
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  //Permite validação do campo
                  decoration: InputDecoration(
                    labelText: "Digite seu nome...",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => setState(() {
                    _nome = value;
                  }),
                  //Operador ternario para ver se o campo não esta vazio
                  validator: (value) =>
                      value!.isEmpty ? "Campo Obrigatorio" : null,
                ),
                //campo email
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Digite seu Email...",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => setState(() {
                    {
                      _email = value;
                    }
                  }),
                  validator: (value) =>
                      value!.contains("@") ? null : "Email Inválido",
                ),
                //Campo senha
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Digite sua Senha...",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() {
                        _obscureSenha =
                            !_obscureSenha; // inverter o valor para a booleana
                      }),
                      //Icone para visibilidade da senha
                      icon: Icon(
                        _obscureSenha ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  onChanged: (value) => setState(() {
                    _senha = value;
                  }),
                  validator: (value) => value!.length <= 6
                      ? " Senha deve ser maior que 6 Caracateres"
                      : null,
                  obscureText: _obscureSenha, //esconder senha
                  //icone para mostrar ou esconder a senha
                ),
                //Campo confirmar senha
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Confirme sua Senha...",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() {
                        _obscureSenha =
                            !_obscureSenha; // inverter o valor para a booleana
                      }),
                      icon: Icon(
                        _obscureSenha ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  onChanged: (value) => setState(() {
                    _confirmarSenha = value;
                  }),
                  validator: (value) =>
                      value != _senha ? "As senhas não correspondem" : null,
                  obscureText: _obscureSenha,
                ),
                //Radio Button => Váriavel sexo
                // SizedBox(height: 20),
                // //Forma antiga
                // Row(
                //   children: [
                //     Text("Sexo: "),
                //     SizedBox(width: 5),
                //     Radio(
                //       value: "Feminino",
                //       groupValue: _sexo,
                //       onChanged: (value) => setState(() => _sexo = value!),
                //     ),
                //     Text("Feminino"),
                //     SizedBox(width: 5),
                //     Radio(
                //       value: "Masculino",
                //       groupValue: _sexo,
                //       onChanged: (value) => setState(() => _sexo = value!),
                //     ),
                //     Text("Masculino"),
                //     SizedBox(width: 5),
                //     Radio(
                //       value: "Outro",
                //       groupValue: _sexo,
                //       onChanged: (value) => setState(() => _sexo = value!),
                //     ),
                //     Text("Outro"),
                //     SizedBox(width: 5),
                //   ],
                // ),
                //Radio versao nova
                //RadioGroup
                RadioGroup<String>(
                  groupValue: _sexo,
                  onChanged: (String? value) => setState(() => _sexo = value!),
                  child: Row(
                    children: [
                      Text("Sexo: "),
                      SizedBox(width: 5),
                      Radio(value: "Feminino"),
                      Text("Feminino"),
                      SizedBox(width: 5),
                      Radio(value: "Masculino"),
                      Text("Masculino"),
                      SizedBox(width: 5),
                      Radio(value: "Outro"),
                      Text("Outro"),
                    ],
                  ),
                ),
                //Slider para seleção de idade
                SizedBox(height: 20),
                Row(
                  children: [
                    Text("idade: ${_idade.toInt()}"), //Exibir idade selecionada
                    Expanded(
                      child: Slider(
                        value: _idade,
                        onChanged: (value) => setState(() => _idade = value),
                        min: 0, //Valor minimo do slider
                        max: 100, // Valor maximo do slider
                        divisions: 100, //N° de divisões do slider
                        label: _idade.toInt().toString(),
                      ),
                    ),
                  ],
                ),
                //CheckBox para Selecionar Interesses
                SizedBox(height: 20),
                Column(
                  children: [
                    Text("Interesses Pessoais:"),
                    Row(
                      children: [
                        Checkbox(
                          value: _interesses.contains("Cinema"),
                          onChanged: (bool? value) => setState(() {
                            value!
                                ? _interesses.add("Cinema")
                                : _interesses.remove("Cinema");
                          }),
                        ),
                        Text("Cinema"),
                        SizedBox(width: 5),
                        Checkbox(
                          value: _interesses.contains("Teatro"),
                          onChanged: (bool? value) => setState(() {
                            value!
                                ? _interesses.add("Teatro")
                                : _interesses.remove("Teatro");
                          }),
                        ),
                        Text("Teatro"),
                        SizedBox(width: 5),
                        Checkbox(
                          value: _interesses.contains("Esporte"),
                          onChanged: (bool? value) => setState(() {
                            value!
                                ? _interesses.add("Esporte")
                                : _interesses.remove("Esporte");
                          }),
                        ),
                        Text("Esporte"),
                        SizedBox(width: 5),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _interesses.contains("Música"),
                          onChanged: (bool? value) => setState(() {
                            value!
                                ? _interesses.add("Música")
                                : _interesses.remove("Música");
                          }),
                        ),
                        Text("Música"),
                        SizedBox(width: 5),
                        Checkbox(
                          value: _interesses.contains("Viagens"),
                          onChanged: (bool? value) => setState(() {
                            value!
                                ? _interesses.add("Viagens")
                                : _interesses.remove("Viagens");
                          }),
                        ),
                        Text("Viagens"),
                        SizedBox(width: 5),
                        Checkbox(
                          value: _interesses.contains("VideoGame"),
                          onChanged: (bool? value) => setState(() {
                            value!
                                ? _interesses.add("VideoGame")
                                : _interesses.remove("VideoGame");
                          }),
                        ),
                        Text("VideoGame"),
                        SizedBox(width: 5),
                      ],
                    ),
                  ],
                ),
                //Dropdow Cidades
                SizedBox(height: 20),
                Text("Cidade"),
                DropdownButtonFormField(
                  //criar uma bordar na caixa de dropdown
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  // items: [
                  //   DropdownMenuItem(child: Text("Americana"), value: "Americana",),
                  //   DropdownMenuItem(child: Text("Campinas"), value: "Campinas",),
                  //   DropdownMenuItem(child: Text("Nova Odessa"), value: "Nova Odessa",),
                  //   DropdownMenuItem(child: Text("Santa Barbara d'Oeste"), value: "Santa Barbara d'Oeste",),
                  //   DropdownMenuItem(child: Text("Sumaré"), value: "Sumaré",),
                  //   DropdownMenuItem(child: Text("Piracicaba"), value: "Piracicaba",),
                  //   DropdownMenuItem(child: Text("Outra"), value: "Outra",),
                  // ],
                  // onChanged: (value) => setState(() => _cidade = value!,))
                  items:
                      [
                            "Americana",
                            "Campinas",
                            "Nova Odessa",
                            "Santa Bárbara d'Oeste",
                            "Sumaré",
                            "Piracicaba",
                            "Outra",
                          ]
                          .map(
                            (cidade) => DropdownMenuItem(
                              value: cidade,
                              child: Text(cidade),
                            ),
                          )
                          .toList(),
                  onChanged: (value) => setState(() => _cidade = value!),
                ),
                Row(
                  children: [
                    Switch(
                      value: _aceitarTermos,
                      onChanged: (bool value) =>
                          setState(() => _aceitarTermos = value),
                    ),
                    Text("Aceitar os termos de uso"),
                  ],
                ),
                //Botão de Enviar o Formulário
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _enviarFormulario(_formKey),
                  child: Text("Enviar Formulário"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _enviarFormulario(dynamic formKey) {
    //verificar os termo do formulário (validação)
    //mostrar um AlertDialog ( modal de alerta)
    if (formKey.currentState!.validate() && _aceitarTermos) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Dados do Formulário"),
          content: SingleChildScrollView(
            //permite a rolagem do modal
            child: ListBody(
              children: [
                Text("Nome: $_nome"),
                Text("Email: $_email"),
                Text("Senha: $_senha"),
                Text("Sexo: $_sexo"),
                Text("Idade: ${_idade.toInt()}"),
                Text("Interesses: ${_interesses.join(", ")}"),
                Text("Cidade: $_cidade"),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                //sem arrow function para fazer várias ações
                //limpar as respostas
                setState(() {
                  _nome = "";
                  _email = "";
                  _senha = "";
                  _confirmarSenha = "";
                  _sexo = "Feminino";
                  _idade = 18;
                  _interesses = [];
                  _cidade = "Americana";
                  _aceitarTermos = false;
                  formKey.currentState!
                      .reset(); //reseta a validação do formulário
                });
                Navigator.popAndPushNamed(context, "/");
              },
              child: Text("Ok"),
            ),
          ],
        ),
      );
    }
  }
}
