import 'package:app_eureka/components/botaoLogin.dart';
import 'package:app_eureka/components/botao_Cadastro.dart';
import 'package:app_eureka/components/decoracao_campo_texto.dart';
import 'package:app_eureka/components/quadrado.dart';
import 'package:app_eureka/core/meu_snackbar.dart';
import 'package:app_eureka/services/autenticacao_servico.dart';
import 'package:app_eureka/tela_inicio.dart';
import 'package:app_eureka/tela_login.dart';
import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget {
  TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  String? _parentesco;

  AutenticacaoServico _autenServico = AutenticacaoServico();

  final _formKey = GlobalKey<FormState>();

  void botaoCadastroClicado() {
    String nome = _nomeController.text;
    String email= _emailController.text;
    String senha = _senhaController.text;
    String parentesco = _parentesco ?? '';

    if(_formKey.currentState!.validate()) {
      print("Cadastro valido");
      print("nome: ${_nomeController.text}, email: ${_emailController.text}, senha: ${_senhaController.text}, parentesco: $_parentesco");
      _autenServico.cadastrarUsuario(nome: nome, email: email, senha: senha, parentesco: parentesco).then((String? erro){
        if(erro != null) {
          mostrarSnackBar(context: context, texto: erro);
        }
        else{
          mostrarSnackBar(context: context, texto: "Cadastro realizado com sucesso", isErro: false);
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaInicio()));
        }
      });
    }
    else{
      print("Cadastro invalido");
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

                  //Eureka 2024
                  const SizedBox(height: 10),
                  const Text(
                    'EUREKA 2024',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Roboto Mono',
                        color: Colors.white),
                  ),

                  //Bem Vindo
                  const SizedBox(height: 50),
                  const Text(
                    'Bem vindo',
                    style: TextStyle(
                        fontFamily: 'Roboto mono',
                        fontSize: 16,
                        color: Colors.white),
                  ),

                  //nome textfield
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      decoration: getTextFieldInputDecoration('Nome'),
                      style: const TextStyle(
                          color: Colors.white, fontFamily: 'Roboto Mono'),
                      controller: _nomeController,
                      validator: (String? value) {
                        if (value == null) {
                          return 'O nome não pode ser vazio';
                        }
                        return null;
                      },
                    ),
                  ),

                  //email textfield
                  const SizedBox(
                    height: 10,
                  ),
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

                  //senha textfield
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      decoration: getTextFieldInputDecoration('Senha'),
                      style: const TextStyle(
                          color: Colors.white, fontFamily: 'Roboto Mono'),
                      obscureText: true,
                      controller: _senhaController,
                      validator: (String? value) {
                        if (value == null) {
                          return 'A senha não pode ser vazia';
                        } else if (value.length < 8) {
                          return 'A senha é muito curta';
                        }
                        return null;
                      },
                    ),
                  ),

                  //confirmar a senha textfield
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      decoration:
                          getTextFieldInputDecoration('Confirme a senha'),
                      style: const TextStyle(
                          color: Colors.white, fontFamily: 'Roboto Mono'),
                      obscureText: true,
                      validator: (String? value) {
                        if (value == null) {
                          return 'A senha não pode ser vazia';
                        } else if (value != _senhaController.text) {
                          return 'As senhas não coincidem';
                        }
                        return null;
                      },
                    ),
                  ),

                  //parentesco
                  const SizedBox(height: 15,),
                   Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<String>(
                    value: 'parente',
                    groupValue: _parentesco,
                    onChanged: (value) {
                      setState(() {
                        _parentesco = value;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: Colors.lightBlue[100],
                  ),
                  const Text('Parente', style: TextStyle(color: Colors.white),),
                  Radio<String>(
                    value: 'aluno',
                    groupValue: _parentesco,
                    onChanged: (value) {
                      setState(() {
                        _parentesco = value;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: Colors.lightBlue[100],
                  ),
                  const Text('Aluno', style: TextStyle(color: Colors.white)),
                ],
              ),

                  //botao de cadastro
                  const SizedBox(height: 20),
                  BotaoCadastro(
                    onTap: botaoCadastroClicado,
                  ),

                  //nao tem uma conta, cadastre-se agora
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Já tem uma conta?',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Roboto Mono'),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TelaLogin()),
                          );
                        },
                        child: const Text('Faça o Login agora',
                            style: TextStyle(
                                color: Colors.lightBlue,
                                fontFamily: 'Roboto Mono',
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
