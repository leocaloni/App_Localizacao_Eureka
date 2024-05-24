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
              SizedBox(height: 50),
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
                      child: _buildEstandeWidget(),
                    ),
                    Positioned(
                      left: 100,
                      top: 0,
                      child: _buildEstandeWidget(),
                    ),
                     Positioned(
                      left: 200,
                      top: 0,
                      child: _buildEstandeWidget(),
                    ),
                    Positioned(
                      left: 300,
                      top: 0,
                      child: _buildEstandeWidget(),
                    ),
                    Positioned(
                      left: 0,
                      top: 100,
                      child: _buildEstandeWidget(),
                    ),
                    Positioned(
                      left: 100,
                      top: 100,
                      child: _buildEstandeWidget(),
                    ),
                    Positioned(
                      left: 200,
                      top: 100,
                      child: _buildEstandeWidget(),
                    ),
                    Positioned(
                      left: 300,
                      top: 100,
                      child: _buildEstandeWidget(),
                    ),
                    Positioned(
                      left: 0,
                      top: 200,
                      child: _buildEstandeWidget(),
                    ),
                    Positioned(
                      left: 100,
                      top: 200,
                      child: _buildEstandeWidget(),
                    ),
                    Positioned(
                      left: 200,
                      top: 200,
                      child: _buildEstandeWidget(),
                    ),
                    Positioned(
                      left: 300,
                      top: 200,
                      child: _buildEstandeWidget(),
                    ),
                    Positioned(
                      left: 300,
                      top: 300,
                      child: _buildEstandeWidget(),
                    ),
                    Positioned(
                      left: 200,
                      top: 300,
                      child: _buildEstandeWidget(),
                    ),
                    Positioned(
                      left: 100,
                      top: 300,
                      child: _buildEstandeWidget(),
                    ),
                    Positioned(
                      left: 0,
                      top: 300,
                      child: _buildEstandeWidget(),
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

  Widget _buildEstandeWidget() {
    return Container(
      width: 60, // Largura do estande
      height: 60, // Altura do estande
      color: Colors.blue, // Cor do estande
      child: const Center(
        child: Text(
          'E', // Texto representando o estande
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
