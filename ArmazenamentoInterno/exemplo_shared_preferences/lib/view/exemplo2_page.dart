import 'package:flutter/material.dart';
import 'package:exemplo_shared_preferences/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Exemplo2Page extends StatefulWidget {
  const Exemplo2Page({super.key});

  @override
  State<Exemplo2Page> createState() => _Exemplo2PageState();
}

class _Exemplo2PageState extends State<Exemplo2Page> {
  late SharedPreferences _prefs; //Escopo late, permite
  // criar uma variavel/obj incialmente nula e mudar o
  // valor depois, pode ser mudada quantas vezes for necessario.

  bool _darkMode = false;

  //Métodos de conexão com o sharedPreferences
  @override
  void initState() {
    //TODO: implement initstate
    super.initState();
    _loadPreferences();
  }

  //Método para buscar dados no shared
  void _loadPreferences() async {
    _prefs =
        await SharedPreferences.getInstance(); //Pega as informações salvas no shared

    setState(() {
      _darkMode = _prefs.getBool("darkMode") ?? false;
      //Verificação de nulidade obrigatoria, ?? se caso a
      // chave darkMode do Shared seja nula (Não tenha valor
      // atribuido ainda) a variavel _darkMode sera false
    });
  }

  //Método para salvar dados no Shared
  void savePreferences() async {
    setState(() {
      _darkMode = !_darkMode; //inverte o valor da booleana
    });
    darkModeNotifier.value = _darkMode;
    await _prefs.setBool("darkMode", _darkMode);
    //Atribuindo o valor da variavel darkMode a chave
    // darkmode do shared
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Modo Escuro com Shared Preferences")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Tema atual: ${_darkMode ? "Escuro" : "Claro"}"),
            Switch(value: _darkMode, onChanged: (_) => savePreferences()),
          ],
        ),
      ),
    );
  }
}
