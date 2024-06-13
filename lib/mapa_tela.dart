import 'package:flutter/material.dart';

class MapaTela extends StatefulWidget {
  final int? numeroEstandeEncontrado;

  MapaTela({this.numeroEstandeEncontrado});

  @override
  _MapaTelaState createState() => _MapaTelaState();
}

class _MapaTelaState extends State<MapaTela> {

  //lista para o mapa
  final List<Map<String, dynamic>> estandes = [
    {'numero': 60, 'posicao': Offset(0, 0)},
    {'numero': 21, 'posicao': Offset(100, 0)},
    {'numero': 33, 'posicao': Offset(200, 0)},
    {'numero': 133, 'posicao': Offset(300, 0)},
    {'numero': 55, 'posicao': Offset(0, 100)},
    {'numero': 67, 'posicao': Offset(100, 100)},
    {'numero': 70, 'posicao': Offset(200, 100)},
    {'numero': 85, 'posicao': Offset(300, 100)},
    {'numero': 93, 'posicao': Offset(0, 200)},
    {'numero': 149, 'posicao': Offset(100, 200)},
    {'numero': 11, 'posicao': Offset(200, 200)},
    {'numero': 124, 'posicao': Offset(300, 200)},
    {'numero': 12, 'posicao': Offset(0, 300)},
    {'numero': 15, 'posicao': Offset(100, 300)},
    {'numero': 14, 'posicao': Offset(200, 300)},
    {'numero': 107, 'posicao': Offset(300, 300)},
  ];

  //lista para os estandes mapeados

  final List<Map<String, dynamic>> estandesTela = [
    {'numero': 60, 'posicao': Offset(15, 215)},
    {'numero': 133, 'posicao': Offset(275, 170)},
    {'numero': 149, 'posicao': Offset(100, 400)},
    {'numero': 12, 'posicao': Offset(0, 300)},
    {'numero': 107, 'posicao': Offset(300, 300)},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: LayoutBuilder(
        builder: (context, constraints) {
          final mapaSize = Size(360, 360); //tamanho do grid
          return Stack(
            children: [
              Center(
                child: Column(
                  children: [

                    const SizedBox(height: 50),

                    //logo
                    Image.asset(
                      'lib/images/logo-IMT-SemNome-Branca.png',
                      height: 50,
                    ),

                    const SizedBox(height: 10),

                    //eureka2024
                    const Text(
                      'EUREKA 2024',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Roboto Mono',
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 20),

                    //barra
                    Container(
                      width: double.infinity,
                      height: 2.0,
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                    ),

                    const SizedBox(height: 60),

                    //mapa
                    Container(
                      width: mapaSize.width, 
                      height: mapaSize.height,
                      color: Colors.grey[300], 
                      child: Stack(
                        children: estandes.map((estande) {
                          return Positioned(
                            left: estande['posicao'].dx,
                            top: estande['posicao'].dy,
                            child: _buildEstandeWidget(estande['numero'].toString()),
                          );
                        }).toList()
                          ..add(Positioned(
                            left: 330,
                            top: 260,
                            child: _buildPortaWidget(),
                          )),
                      ),
                    ),
                  ],
                ),
              ),

              //passa as informacoes para achar o caminho
              if (widget.numeroEstandeEncontrado != null)
                CustomPaint(
                  size: mapaSize,
                  painter: PathPainter(
                    widget.numeroEstandeEncontrado!,
                    estandesTela,
                    mapaSize,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }


  //widget para construção dos estandes
  Widget _buildEstandeWidget(String estande) {
    return Container(
      width: 60, 
      height: 60, 
      color: Colors.blue, 
      child: Center(
        child: Text(
          estande, 
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  //widget para a construção da porta
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


//classe para criação dos caminhos
class PathPainter extends CustomPainter {
  final int numeroEstandeEncontrado;
  final List<Map<String, dynamic>> estandesTela;
  final Size mapa;

  PathPainter(this.numeroEstandeEncontrado, this.estandesTela, this.mapa);

  @override
  void paint(Canvas canvas, Size size) {
    final portaPosition = Offset(340, 500);

    final estandeEncontrado = estandesTela.firstWhere(
      (estande) => estande['numero'] == numeroEstandeEncontrado,
      orElse: () => {'numero': -1, 'posicao': Offset.zero},
    );

    if (estandeEncontrado['numero'] != -1) {
      final estandePosition = estandeEncontrado['posicao'];

      final paint = Paint()
        ..color = Colors.black
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke;

      
      final path = Path();

      path.moveTo(portaPosition.dx - 10, portaPosition.dy - 7);

      path.lineTo(portaPosition.dx - 45, portaPosition.dy - 7);
      
      //caminhos para os estandes
      if(estandeEncontrado['numero'] == 133) {
        path.lineTo(portaPosition.dx - 45, estandePosition.dy + 75);
        path.lineTo(estandePosition.dx + 40, estandePosition.dy + 75);
      }

      else if(estandeEncontrado['numero'] == 60) {
        path.lineTo(portaPosition.dx - 45, estandePosition.dy + 75);
        path.lineTo(estandePosition.dx + 80, estandePosition.dy + 75);
        path.lineTo(estandePosition.dx + 80, estandePosition.dy + 27);
        path.lineTo(estandePosition.dx + 65, estandePosition.dy + 27);
      }

      else if(estandeEncontrado['numero'] == 149) {
        path.lineTo(portaPosition.dx - 193,estandePosition.dy + 93);
        path.lineTo(portaPosition.dx - 193, estandePosition.dy + 75);
      }
      
      else if(estandeEncontrado['numero'] == 12) {
        path.lineTo(portaPosition.dx - 245,estandePosition.dy + 193);
        path.lineTo(portaPosition.dx - 245,estandePosition.dy + 245);
        path.lineTo(portaPosition.dx - 260,estandePosition.dy + 245);
      }

      else if(estandeEncontrado['numero'] == 107) {
        path.lineTo(portaPosition.dx - 45,estandePosition.dy + 245);
        path.lineTo(portaPosition.dx - 25,estandePosition.dy + 245);
      }



      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

