import 'package:app_eureka/services/autenticacao_servico.dart';
import 'package:app_eureka/tela_perfil.dart';
import 'package:flutter/material.dart';

class TelaInicio extends StatefulWidget {
  @override
  State<TelaInicio> createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicio> {

  int itemSelecionado= 0;

  static  final List<Widget> _widgetOptions = <Widget>[
    const Text(
      'Index 0: Mapa'
    ),
    const Text(
      'Index 1: Buscar trabalho'
    ),
    TelaPerfil(),
  ];

  final AutenticacaoServico _autenticacaoServico =
      AutenticacaoServico(); 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: _widgetOptions.elementAt(itemSelecionado),
      bottomNavigationBar: BottomNavigationBar(currentIndex: itemSelecionado,
      backgroundColor: Colors.lightBlue[800],
      selectedItemColor: Colors.white,
      showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map_rounded), label: "Mapa"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Buscar trabalho"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded), label: "Perfil"),
        ],
        onTap: (valor){
          setState(() {
            itemSelecionado = valor;
          });
        },
      ),
    );
  }
}
