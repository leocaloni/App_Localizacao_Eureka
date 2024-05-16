import 'package:app_eureka/components/botaoLogin.dart';
import 'package:app_eureka/components/decoracao_campo_texto.dart';
import 'package:app_eureka/components/quadrado.dart';
import 'package:app_eureka/core/meu_snackbar.dart';
import 'package:app_eureka/services/autenticacao_servico.dart';
import 'package:app_eureka/tela_cadastro.dart';
import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  //controllers para o texto
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  AutenticacaoServico _autenServico = AutenticacaoServico();

  final _formKey = GlobalKey<FormState>();

  //metodo login usuario:
  void botaoLoginClicado() {
    String email = _emailController.text;
    String senha = _senhaController.text;

    if (_formKey.currentState!.validate()){
      print("Login valido");
      _autenServico.logarUsuario(email: email, senha: senha).then((String? erro){
        if(erro!= null){
          mostrarSnackBar(context: context, texto: erro);
        }
      });
    }
    else{
      print("Form Invalido");
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
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
            
                const SizedBox(height: 50),
                //logo
                Image.asset('lib/images/logo-IMT-Completa-Branca.png', height: 100),
            
                //Eureka 2024
                const SizedBox(height: 10),
                const Text('EUREKA 2024', style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Roboto Mono',
                  color: Colors.white
                ),),
            
                //Bem Vindo
                const SizedBox(height: 50),
                const Text('Bem vindo',
                style: TextStyle(
                  fontFamily: 'Roboto mono',
                  fontSize: 16,
                  color: Colors.white
                ),),
            
                //email textfield
                const SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    decoration: getTextFieldInputDecoration('Email'),
                    style: const TextStyle(color: Colors.white, fontFamily: 'Roboto Mono'),
                    controller: _emailController,
                    validator: (String? value) {
                    if(value == null) {
                      return 'O email não pode ser vazio';
                    }
                    else if(value.length < 5) {
                      return 'O email é muito curto';
                    }
                    else if(!value.contains('@')){
                      return 'Digite um email válido';
                    }
                    return null;
                  },

                  ),
                ),

                //senha textfield
                const SizedBox(height: 10),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
                 child: TextFormField(
                  decoration: getTextFieldInputDecoration('Senha'),
                  style: const TextStyle(color: Colors.white, fontFamily: 'Roboto Mono'),
                  obscureText: true,
                  controller: _senhaController,
                  validator: (String? value) {
                    if (value == null) {
                      return 'A senha não pode ser vazia';
                    }
                    else if(value.length < 8) {
                      return 'A senha é muito curta';
                    }
                    return null;
                  },
                 ),
               ),
            
                //esqueceu a senha
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Esqueceu a senha?',
                      style: TextStyle(color: Colors.white, fontFamily: 'Roboto Mono', fontSize: 14) ,),
                    ],
                  ),
                ),
            
                //botao de login
              const SizedBox(height: 20),
              BotaoLogin(onTap: botaoLoginClicado,),
            
                //ou continue com
              const SizedBox(height: 25),
            
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(child: Divider(thickness: 0.5,
                    color: Colors.blue[400],),
                    ),
                
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('Ou continue com', style: TextStyle(color: Colors.blue[500], fontFamily: 'Roboto Mono'),),
                    ),
                
                    Expanded(child: Divider(thickness: 0.5,
                    color: Colors.blue[400],),
                    )
                  ],
                ),
              ),
            
                //google botao
                const SizedBox(height: 10),
                
                const Quadrado(imagePath: 'lib/images/logo_google.png'),
            
                //nao tem uma conta, cadastre-se agora
                const SizedBox(height: 10,),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Não tem uma conta?', style: TextStyle(color: Colors.white, fontFamily: 'Roboto Mono'),),
                  const SizedBox(width: 4,),
                  GestureDetector( 
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TelaCadastro()),
                      );
                    },
                    child: const Text('Cadastre-se agora', style: TextStyle(color: Colors.lightBlue, fontFamily: 'Roboto Mono', fontWeight: FontWeight.bold)),
                  ),
                ],
                )
            
              ],),
            ),
          ),
        ),
      ),
    );
  }
}