import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/abastecimento.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Abastecimento> abastecimentos = [];

  @override
  void initState() {
    super.initState();
    carregar();
  }

  Future<void> carregar() async {
    final prefs = await SharedPreferences.getInstance();
    final dados = prefs.getString('abastecimentos');

    if (dados != null) {
      setState(() {
        abastecimentos = (jsonDecode(dados) as List)
            .map(
              (e) => Abastecimento.fromMap(
                Map<String, dynamic>.from(e),
              ),
            )
            .toList();
      });
    }
  }

  Future<void> salvar() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'abastecimentos',
      jsonEncode(
        abastecimentos.map((e) => e.toMap()).toList(),
      ),
    );
  }

  void formulario([int? index]) {
    final item = index == null ? null : abastecimentos[index];

    final data = TextEditingController(
      text: item?.data ?? '',
    );

    final combustivel = TextEditingController(
      text: item?.combustivel ?? '',
    );

    final litros = TextEditingController(
      text: item?.litros.toString() ?? '',
    );

    final valor = TextEditingController(
      text: item?.valorPago.toString() ?? '',
    );

    final km = TextEditingController(
      text: item?.quilometragem.toString() ?? '',
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            index == null
                ? 'Novo abastecimento'
                : 'Editar abastecimento',
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                campo(data, 'Data'),
                campo(combustivel, 'Combustível'),
                campo(litros, 'Litros'),
                campo(valor, 'Valor pago'),
                campo(km, 'Quilometragem'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final novo = Abastecimento(
                  data: data.text,
                  combustivel: combustivel.text,
                  litros: double.tryParse(litros.text) ?? 0,
                  valorPago: double.tryParse(valor.text) ?? 0,
                  quilometragem: double.tryParse(km.text) ?? 0,
                );

                if (novo.data.isEmpty ||
                    novo.combustivel.isEmpty ||
                    novo.litros <= 0 ||
                    novo.valorPago <= 0 ||
                    novo.quilometragem <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Preencha todos os campos corretamente.',
                      ),
                    ),
                  );
                  return;
                }

                setState(() {
                  if (index == null) {
                    abastecimentos.add(novo);
                  } else {
                    abastecimentos[index] = novo;
                  }
                });

                await salvar();

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  Widget campo(
    TextEditingController controller,
    String texto,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        keyboardType:
            texto == 'Data' || texto == 'Combustível'
                ? TextInputType.text
                : const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
        decoration: InputDecoration(
          labelText: texto,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
    );
  }

  void excluir(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir'),
          content: const Text(
            'Deseja excluir este abastecimento?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Não'),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  abastecimentos.removeAt(index);
                });

                await salvar();

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 65,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),

                  const Expanded(
                    child: Text(
                      'Abastecimentos',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      formulario();
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: abastecimentos.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhum abastecimento',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: abastecimentos.length,
                      itemBuilder: (context, index) {
                        final item = abastecimentos[index];

                        return InkWell(
                          onTap: () {
                            formulario(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.local_gas_station,
                                    size: 25,
                                  ),
                                ),

                                const SizedBox(width: 15),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.combustivel,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 5),

                                      Text(
                                        '${item.litros} L  •  R\$ ${item.valorPago.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 14,
                                        ),
                                      ),

                                      const SizedBox(height: 3),

                                      Text(
                                        '${item.data}  •  ${item.quilometragem} km',
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                IconButton(
                                  onPressed: () {
                                    excluir(index);
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    size: 27,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}