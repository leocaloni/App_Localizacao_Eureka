import 'package:app_eureka/tela_inicio.dart';
import 'package:flutter/material.dart';
import 'mapa_tela.dart';

class DescricaoTrabalhoTela extends StatefulWidget {
  final String tituloTrabalho;
  final String descricaoTrabalho;
  final int numeroEstandeEncontrado;
  final List<String> historicoTrabalho;
  final List<String> historicoAluno;

  const DescricaoTrabalhoTela({
    Key? key,
    required this.tituloTrabalho,
    required this.descricaoTrabalho,
    required this.numeroEstandeEncontrado,
    required this.historicoTrabalho,
    required this.historicoAluno,
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

              const SizedBox(height: 50),

              //logo
              Image.asset(
                'lib/images/logo-IMT-SemNome-Branca.png',
                height: 50,
              ),

              const SizedBox(height: 10),

              //eureka 2024
              const Text(
                'EUREKA 2024',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Roboto Mono',
                    color: Colors.white),
              ),

              const SizedBox(height: 20),

              //barra
              Container(
                width: double.infinity,
                height: 2.0,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),


              //titulo trabalho
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.tituloTrabalho,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto Mono'),
                ),
              ),

              const SizedBox(height: 25),

              //numero do estande
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Número do Estande: ${widget.numeroEstandeEncontrado}",
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Roboto Mono'),
                ),
              ),

              const SizedBox(height: 10),

              //descricao do trabalho
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.descricaoTrabalho,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'Roboto Mono',
                  ),
                ),
              ),

              const SizedBox(height: 25),
              
              //botao para achar caminho
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapaTela(
                        numeroEstandeEncontrado: widget.numeroEstandeEncontrado,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  'Mostrar caminho',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto Mono',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 25),
              //botao para voltar
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)  => TelaInicio()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  'Voltar',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto Mono',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
