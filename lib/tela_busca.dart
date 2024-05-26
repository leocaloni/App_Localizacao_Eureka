import 'package:app_eureka/components/decoracao_campo_texto.dart';
import 'package:app_eureka/core/meu_snackbar.dart';
import 'package:app_eureka/descricao_trabalho_tela.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TelaBusca extends StatefulWidget {
  @override
  State<TelaBusca> createState() => _TelaBuscaState();
}

class _TelaBuscaState extends State<TelaBusca> {
  bool buscarPorTrabalho = true;
  final TextEditingController _controllerBusca = TextEditingController();

  bool trabalhoEncontrado = false;
  String tituloTrabalhoEncontrado = '';
  String descricaoTrabalhoEncontrada = '';
  int numeroEstandeEncontrado = 0;
  List<String> sugestoesBusca = [];


// metodo para sugestoes de busca
  Future<void> _buscarSugestoes(String termoDeBusca) async {
  if (termoDeBusca.isEmpty) {
    setState(() {
      sugestoesBusca = [];
    });
    return;
  }


  termoDeBusca = termoDeBusca.toUpperCase();

  CollectionReference trabalhosRef = FirebaseFirestore.instance.collection('trabalhos');
  QuerySnapshot querySnapshot;

  try {
    if (buscarPorTrabalho) {
      querySnapshot = await trabalhosRef
          .where('tituloTrabalho', isGreaterThanOrEqualTo: termoDeBusca)
          .where('tituloTrabalho', isLessThanOrEqualTo: termoDeBusca + '\uf8ff')
          .get();
    } else {
      querySnapshot = await trabalhosRef
          .where('nomeAluno', isGreaterThanOrEqualTo: termoDeBusca)
          .where('nomeAluno', isLessThanOrEqualTo: termoDeBusca + '\uf8ff')
          .get();
    }

    List<String> novasSugestoes = querySnapshot.docs.map((doc) {
      Map<String, dynamic> dados = doc.data() as Map<String, dynamic>;
      return buscarPorTrabalho ? dados['tituloTrabalho'] as String : dados['nomeAluno'] as String;
    }).toList();

   setState(() {
      sugestoesBusca = novasSugestoes.toSet().toList();
    });
  } catch (e) {
    print('Erro ao buscar sugestões: $e');
  }
}

    //metodo para buscar trabalhos

  Future<void> _buscarTrabalhos(String termoDeBusca) async {
    CollectionReference trabalhosRef = FirebaseFirestore.instance.collection('trabalhos');
    QuerySnapshot querySnapshot;

    if (buscarPorTrabalho) {
      querySnapshot = await trabalhosRef
          .where('tituloTrabalho', isEqualTo: termoDeBusca)
          .get();
    } else {
      querySnapshot = await trabalhosRef
          .where('nomeAluno', isEqualTo: termoDeBusca)
          .get();
    }

    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> dadosTrabalho = doc.data() as Map<String, dynamic>;
        tituloTrabalhoEncontrado = dadosTrabalho['tituloTrabalho'];
        descricaoTrabalhoEncontrada = dadosTrabalho['descricaoTrabalho'];
         numeroEstandeEncontrado = dadosTrabalho['numeroEstande'];
        trabalhoEncontrado = true;
      });
    } else {
      trabalhoEncontrado = false;
    }

    setState(() {});
  }

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

              const SizedBox(height: 75),

              const Text(
                'Selecione o método de busca:',
                style: TextStyle(
                    fontSize: 18, fontFamily: 'Roboto Mono', color: Colors.white),
              ),

              const SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        buscarPorTrabalho = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo[900],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    child: const Text(
                      'Buscar por Trabalho',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto Mono',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        buscarPorTrabalho = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo[900],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    child: const Text(
                      'Buscar por Aluno',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto Mono',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _controllerBusca,
                  onChanged: (value) {
                    _buscarSugestoes(value);
                  },
                  decoration: getTextFieldInputDecoration(
                    buscarPorTrabalho ? 'Nome do Trabalho' : 'Nome do Aluno',
                  ),
                  style: const TextStyle(
                      color: Colors.white, fontFamily: 'Roboto Mono'),
                ),
              ), 

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: sugestoesBusca.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.indigo[900],
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: ListTile(
                        title: Text(
                          sugestoesBusca[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          _controllerBusca.text = sugestoesBusca[index];
                          sugestoesBusca.clear();
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 10),
              
              ElevatedButton(
                onPressed: () async {
                  String termoDeBusca = _controllerBusca.text;
                  await _buscarTrabalhos(termoDeBusca);
                  if (trabalhoEncontrado) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DescricaoTrabalhoTela(
                          tituloTrabalho: tituloTrabalhoEncontrado,
                          descricaoTrabalho: descricaoTrabalhoEncontrada,
                          numeroEstandeEncontrado: numeroEstandeEncontrado,
                        ),
                      ),
                    );
                  } else {
                    mostrarSnackBar(
                        context: context, texto: "Trabalho não encontrado.");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                child: const Text(
                  'Buscar',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto Mono',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              const SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}
