import 'package:app_eureka/services/autenticacao_servico.dart';
import 'package:flutter/material.dart';

class TelaInicio extends StatelessWidget {
  final AutenticacaoServico _autenticacaoServico = AutenticacaoServico(); // Criando uma instância do serviço de autenticação

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tela Inicial"),
      ),
      drawer:  Drawer(
        child: ListView(children: [
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Sair"),
            onTap: () {
              _autenticacaoServico.deslogarUsuario(); // Chamando o método em uma instância da classe
            },
          ) 
        ]),
      ),
    );
  }
}
