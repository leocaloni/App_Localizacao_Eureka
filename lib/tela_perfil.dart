import 'package:app_eureka/services/autenticacao_servico.dart';
import 'package:app_eureka/tela_login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TelaPerfil extends StatefulWidget {
  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Informacoes a serem exibidas no perfil
  User? user;
  String userName = "Carregando...";
  String userEmail = "Carregando...";
  String userParentesco = "Carregando...";

  AutenticacaoServico _autenServico = AutenticacaoServico();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  //metodo para pegar as informações do perfil
  Future<void> _fetchUserData() async {
    user = _auth.currentUser;
    if (user != null) {
      setState(() {
        userName = user!.displayName ?? "Nome não disponível";
        userEmail = user!.email ?? "Email não disponível";
        userParentesco = user!.photoURL ?? "Parentesco não disponível";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 50,),

              //logo
              Image.asset('lib/images/logo-IMT-SemNome-Branca.png', height: 50,),
              const SizedBox(height: 10,),
              const Text(
                'EUREKA 2024',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Roboto Mono',
                  color: Colors.white
                ),
              ),

              const SizedBox(height: 20,),
              
              //barra
              Container(
                width: double.infinity,
                height: 2.0,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),

              const SizedBox(height: 150,),

              //nome do Usuario
              Text(
                'Bem Vindo, $userName',
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Roboto Mono',
                  color: Colors.white
                ),
              ),

              const SizedBox(height: 25,),

              //email do Usuario
              Text(
                'Email: $userEmail',
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Roboto Mono',
                  color: Colors.white
                ),
              ),

              const SizedBox(height: 10,),

              //parentesco do Usuario
              Text(
                'Parentesco: $userParentesco',
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Roboto Mono',
                  color: Colors.white
                ),
              ),

              const SizedBox(height: 20,),
              
              //botao de logout
              ElevatedButton(
                onPressed: () { 
                  _autenServico.deslogarUsuario();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => TelaLogin()));},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[900],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)) // Background color
                ),
                child: const Text('Sair', style: TextStyle(color: Colors.white, fontFamily: 'Roboto mono', fontWeight: FontWeight.bold),),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
