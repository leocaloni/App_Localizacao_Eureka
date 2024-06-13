import 'package:app_eureka/components/decoracao_campo_texto.dart';
import 'package:app_eureka/core/meu_snackbar.dart';
import 'package:app_eureka/descricao_trabalho_tela.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TelaBusca extends StatefulWidget {
  @override
  State<TelaBusca> createState() => _TelaBuscaState();
}

class _TelaBuscaState extends State<TelaBusca> {
  bool buscarPorTrabalho = true;
  final TextEditingController _controllerBusca = TextEditingController();
  bool _mostraHistoricoTrabalho = false;
  bool _mostraHistoricoAluno = false;
  bool trabalhoEncontrado = false;
  String tituloTrabalhoEncontrado = '';
  String descricaoTrabalhoEncontrada = '';
  int numeroEstandeEncontrado = 0;
  List<String> sugestoesBusca = [];

  @override
  void initState() {
    super.initState();
    _carregarHistorico();
  }

  void _carregarHistorico() {
    // Carregar o histórico de busca da classe HistoricoBusca
    _mostraHistoricoTrabalho = true;
    _mostraHistoricoAluno = true;
  }

  //metodo para buscar as sugestões de busca
  Future<void> _buscarSugestoes(String termoDeBusca) async {
    if (termoDeBusca.isEmpty) {
      setState(() {
        sugestoesBusca = [];
      });
      return;
    }

    termoDeBusca = termoDeBusca.toUpperCase();

    CollectionReference trabalhosRef =
        FirebaseFirestore.instance.collection('trabalhos');
    QuerySnapshot querySnapshot;

    try {
      if (buscarPorTrabalho) {
        querySnapshot = await trabalhosRef
            .where('tituloTrabalho', isGreaterThanOrEqualTo: termoDeBusca)
            .where('tituloTrabalho',
                isLessThanOrEqualTo: termoDeBusca + '\uf8ff')  //garante que a sugestão começa com o termo de busca
            .get();
      } else {
        querySnapshot = await trabalhosRef
            .where('nomeAluno', isGreaterThanOrEqualTo: termoDeBusca)
            .where('nomeAluno', isLessThanOrEqualTo: termoDeBusca + '\uf8ff')
            .get();
      }
      
      //atualiza as sugestões dinâmicamente
      List<String> novasSugestoes = querySnapshot.docs.map((doc) {
        Map<String, dynamic> dados = doc.data() as Map<String, dynamic>;
        return buscarPorTrabalho
            ? dados['tituloTrabalho'] as String
            : dados['nomeAluno'] as String;
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
    CollectionReference trabalhosRef =
        FirebaseFirestore.instance.collection('trabalhos');
    QuerySnapshot querySnapshot;

    if (buscarPorTrabalho) {
      querySnapshot = await trabalhosRef
          .where('tituloTrabalho', isEqualTo: termoDeBusca)
          .get();
    } else {
      querySnapshot =
          await trabalhosRef.where('nomeAluno', isEqualTo: termoDeBusca).get();
    }

    if (querySnapshot.docs.isNotEmpty) {
      //pega as informações necessárias do trabalho para passar para a próxima tela
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

    if (trabalhoEncontrado) {
      HistoricoBusca.adicionarBusca(termoDeBusca, buscarPorTrabalho);
    }
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

              //logo
              Image.asset('lib/images/logo-IMT-SemNome-Branca.png', height: 50),

              const SizedBox(height: 10),

              //Eureka 2024
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

              const SizedBox(height: 75),

              //Selecione o metodo de busc
              const Text(
                'Selecione o método de busca:',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto Mono',
                    color: Colors.white),
              ),

              const SizedBox(height: 50),

              //opções de busca
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        buscarPorTrabalho = true;
                        _mostraHistoricoTrabalho = true;
                        _mostraHistoricoAluno = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo[900],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    child: const Text(
                      'Buscar por Trabalho',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto Mono',
                          color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        buscarPorTrabalho = false;
                        _mostraHistoricoTrabalho = false;
                        _mostraHistoricoAluno = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo[900],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    child: const Text(
                      'Buscar por Aluno',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto Mono',
                          color: Colors.white),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              //textField para a busca
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

              const SizedBox(height: 20,),

              //histórico de busca feito com fila
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors
                          .white), // Adicione uma borda branca ao redor do container
                  borderRadius:
                      BorderRadius.circular(10.0), // Borda arredondada
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        buscarPorTrabalho
                            ? 'Histórico de Trabalho'
                            : 'Histórico de Aluno',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: buscarPorTrabalho
                          ? HistoricoBusca.historicoTrabalho.elements.length
                          : HistoricoBusca.historicoAluno.elements.length,
                      itemBuilder: (context, index) {
                        String termo = buscarPorTrabalho
                            ? HistoricoBusca.historicoTrabalho.elements[index]
                            : HistoricoBusca.historicoAluno.elements[index];
                        return ListTile(
                          title: Text(
                            termo,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                          onTap: () {
                            _controllerBusca.text = termo;
                            setState(() {
                              buscarPorTrabalho
                                  ? _mostraHistoricoTrabalho = false
                                  : _mostraHistoricoAluno = false;
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),

              //lista de sugestões
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sugestoesBusca.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.indigo[900],
                          borderRadius: BorderRadius.circular(8)),
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

              //botao para buscar
              ElevatedButton(
                onPressed: () async {
                  String termoDeBusca = _controllerBusca.text;
                  await _buscarTrabalhos(termoDeBusca);
                  HistoricoBusca.adicionarBusca(
                      termoDeBusca, buscarPorTrabalho);
                  print(HistoricoBusca.historicoAluno.elements);
                  if (trabalhoEncontrado) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DescricaoTrabalhoTela(
                          tituloTrabalho: tituloTrabalhoEncontrado,
                          descricaoTrabalho: descricaoTrabalhoEncontrada,
                          numeroEstandeEncontrado: numeroEstandeEncontrado,
                          historicoTrabalho:
                              HistoricoBusca.historicoTrabalho.elements,
                          historicoAluno:
                              HistoricoBusca.historicoAluno.elements,
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
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}


//fila dos históricos

class Queue<T> {
  List<T> _elements = [];
  final int _maxSize;

  Queue(this._maxSize);

  bool isFull() {
    return _elements.length == _maxSize;
  }

  void enqueue(T element) {
    if (isFull()) {
      _elements.removeAt(0);
    }
    if (!_elements.contains(element)) {
      _elements.add(element);
    }
  }

  List<T> get elements => List.unmodifiable(_elements);
}


//classe com os históricos
class HistoricoBusca {
  static final Queue<String> historicoTrabalho = Queue<String>(3);
  static final Queue<String> historicoAluno = Queue<String>(3);

  static void adicionarBusca(String termo, bool buscarPorTrabalho) {
    if (buscarPorTrabalho) {
      historicoTrabalho.enqueue(termo);
    } else {
      historicoAluno.enqueue(termo);
    }
  }
}
