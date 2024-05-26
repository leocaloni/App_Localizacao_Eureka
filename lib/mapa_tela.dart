import 'package:flutter/material.dart';

class MapaTela extends StatefulWidget {
  @override
  _MapaTelaState createState() => _MapaTelaState();
}

class _MapaTelaState extends State<MapaTela> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              const SizedBox(height: 50),

              Image.asset('lib/images/logo-IMT-SemNome-Branca.png', height: 50),

              const SizedBox(height: 10),

              const Text(
                'EUREKA 2024',
                style: TextStyle(
                    fontSize: 15, fontFamily: 'Roboto Mono', color: Colors.white),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                height: 2.0,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),

              const SizedBox(height: 60),

              Container(
                width: 360, // Largura total do grid
                height: 360, // Altura total do grid
                color: Colors.grey[300], // Cor de fundo do grid
                child: Stack(
                  children: [
                    // Estandes na parede superior
                    Positioned(
                      left: 0,
                      top: 0,
                      child: _buildEstandeWidget('1'),
                    ),
                    Positioned(
                      left: 100,
                      top: 0,
                      child: _buildEstandeWidget('2'),
                    ),
                     Positioned(
                      left: 200,
                      top: 0,
                      child: _buildEstandeWidget('3'),
                    ),
                    Positioned(
                      left: 300,
                      top: 0,
                      child: _buildEstandeWidget('4'),
                    ),
                    Positioned(
                      left: 0,
                      top: 100,
                      child: _buildEstandeWidget('5'),
                    ),
                    Positioned(
                      left: 100,
                      top: 100,
                      child: _buildEstandeWidget('6'),
                    ),
                    Positioned(
                      left: 200,
                      top: 100,
                      child: _buildEstandeWidget('7'),
                    ),
                    Positioned(
                      left: 300,
                      top: 100,
                      child: _buildEstandeWidget('8'),
                    ),
                    Positioned(
                      left: 0,
                      top: 200,
                      child: _buildEstandeWidget('9'),
                    ),
                    Positioned(
                      left: 100,
                      top: 200,
                      child: _buildEstandeWidget('10'),
                    ),
                    Positioned(
                      left: 200,
                      top: 200,
                      child: _buildEstandeWidget('11'),
                    ),
                    Positioned(
                      left: 300,
                      top: 200,
                      child: _buildEstandeWidget('12'),
                    ),
                    Positioned(
                      left: 300,
                      top: 300,
                      child: _buildEstandeWidget('13'),
                    ),
                    Positioned(
                      left: 200,
                      top: 300,
                      child: _buildEstandeWidget('14'),
                    ),
                    Positioned(
                      left: 100,
                      top: 300,
                      child: _buildEstandeWidget('15'),
                    ),
                    Positioned(
                      left: 330,
                      top: 260,
                      child: _buildPortaWidget(),
                    ),
                    Positioned(
                      left: 0,
                      top: 300,
                      child: _buildEstandeWidget('16'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEstandeWidget(String estande) {
    return Container(
      width: 60, // Largura do estande
      height: 60, // Altura do estande
      color: Colors.blue, // Cor do estande
      child: Center(
        child: Text(
          estande, // Texto representando o estande
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildPortaWidget() {
    return Container(
      width: 30, // Largura do estande
      height: 40, // Altura do estande
      color: Colors.red, // Cor do estande
      child: const Center(
        child: Text(
          'Porta', // Texto representando o estande
          style: TextStyle(color: Colors.white, fontSize: 11),
        ),
      ),
    );
  }
}
