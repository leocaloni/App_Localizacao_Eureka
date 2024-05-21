import 'package:app_eureka/tela_inicio.dart';
import 'package:flutter/material.dart';

class DescricaoTrabalhoTela extends StatefulWidget {
  // Adiciona as variáveis para armazenar o título e a descrição do trabalho
  final String tituloTrabalho;
  final String descricaoTrabalho;

  // Construtor que recebe o título e a descrição do trabalho como parâmetros
  const DescricaoTrabalhoTela({
    Key? key,
    required this.tituloTrabalho,
    required this.descricaoTrabalho,
  }) : super(key: key);

  @override
  State<DescricaoTrabalhoTela> createState() => _DescricaoTrabalhoTelaState();
}

class _DescricaoTrabalhoTelaState extends State<DescricaoTrabalhoTela> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
             const SizedBox(
                height: 50,
              ),
              Image.asset(
                'lib/images/logo-IMT-SemNome-Branca.png',
                height: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'EUREKA 2024',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Roboto Mono',
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),

              Container(
                width: double.infinity,
                height: 2.0,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.tituloTrabalho,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto Mono'
                  ),
                ),
              ),
              
              const SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.descricaoTrabalho,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'Roboto Mono'
                  ),
                ),
              ),

              const SizedBox(height: 25,),
              ElevatedButton(
                onPressed: () { },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[900],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                ),
                child: const Text('Mostrar caminho', style: TextStyle(color: Colors.white, fontFamily: 'Roboto mono', fontWeight: FontWeight.bold),),
              ),

              const SizedBox(height: 25,),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaInicio()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[900],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                ),
                child: const Text('Voltar', style: TextStyle(color: Colors.white, fontFamily: 'Roboto mono', fontWeight: FontWeight.bold),),
              ),


            ],
          ),
        ),
      ),
    );
  }
}