import 'package:app_eureka/components/decoracao_campo_texto.dart';
import 'package:app_eureka/core/meu_snackbar.dart';
import 'package:app_eureka/services/autenticacao_servico.dart';
import 'package:app_eureka/tela_login.dart';
import 'package:flutter/material.dart';

class EsqueceuASenhaTela extends StatefulWidget {
  @override
  State<EsqueceuASenhaTela> createState() => _EsqueceuASenhaTelaState();
}

AutenticacaoServico _autenServico = AutenticacaoServico();
final _formKey = GlobalKey<FormState>();

final _emailController = TextEditingController();


class _EsqueceuASenhaTelaState extends State<EsqueceuASenhaTela> {

  //metodo para enviar o email de troca de senha
  void botaoEnviarPressionado () {
  String email = _emailController.text;

  if(_formKey.currentState!.validate()){
    print("Email para resetar a senha enviado.");
    _autenServico.resetarSenha(email: email).then((String? erro){
      if(erro!=null){
        mostrarSnackBar(context: context, texto: erro, isErro: true);
      }
      else{
        mostrarSnackBar(context: context, texto: "O email foi enviado com sucesso, verifique seu email para trocar a senha.", isErro: false);
      }
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const SizedBox(height: 50),

                  //logo
                  Image.asset('lib/images/logo-IMT-Completa-Branca.png',
                      height: 100),

                  const SizedBox(height: 10),

                   //Eureka 2024
                  const Text(
                    'EUREKA 2024',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Roboto Mono',
                        color: Colors.white),
                  ),

                  const SizedBox(height: 50),

                  //recuperacao de senha
                  const Text(
                    'Recuperação de senha',
                    style: TextStyle(
                        fontFamily: 'Roboto mono',
                        fontSize: 16,
                        color: Colors.white),
                  ),

                  const SizedBox(height: 25,),

                  //textField para o email
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      decoration: getTextFieldInputDecoration('Email'),
                      style: const TextStyle(
                          color: Colors.white, fontFamily: 'Roboto Mono'),
                      controller: _emailController,
                      validator: (String? value) {
                        if (value == null) {
                          return 'O email não pode ser vazio';
                        } else if (value.length < 5) {
                          return 'O email é muito curto';
                        } else if (!value.contains('@')) {
                          return 'Digite um email válido';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  //texto informativo
                  const Text(
                    'Um email será enviado para você trocar sua senha.',
                    style: TextStyle(
                        fontFamily: 'Roboto mono',
                        fontSize: 14,
                        color: Colors.white),
                  ),

                  const SizedBox(height: 20,),

                  //botao para enviar o email
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: ElevatedButton(
                      onPressed: botaoEnviarPressionado,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo[900],
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8)) // Background color
                          ),
                      child: const Text(
                        'Enviar',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto mono'),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),

                  //voltar para o inicio
                  GestureDetector( 
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TelaLogin()),
                      );
                    },
                    child: const Text('Voltar para o início', style: TextStyle(color: Colors.lightBlue, fontFamily: 'Roboto Mono', fontWeight: FontWeight.bold)),
                  ),

                  const SizedBox(height: 150,),
                  Image.asset('lib/images/logo-IMT-SemNome-Branca.png', height: 40,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
