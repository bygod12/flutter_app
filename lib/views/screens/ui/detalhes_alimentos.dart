import 'package:flutter/material.dart';
import 'package:untitled1/controllers/refeicoesController.dart';
import 'package:untitled1/views/screens/ui/refeicoes.dart';

import '../../../models/refeicao.dart';
class FoodDetailsScreen extends StatefulWidget {
  late final String foodName;
  late final double carbs;
  late final double fats;
  late final double proteins;
  late final double fibers;
  late final double calories;
  final int id;
  final RefeicaoController refeicaoController;

  FoodDetailsScreen({
    Key? key,
    required this.id,
    required this.foodName,
    required this.carbs,
    required this.fats,
    required this.proteins,
    required this.fibers,
    required this.calories,
    required this.refeicaoController,

  }) : super(key: key);

  @override
_FoodDetailsScreenState createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  late String showfoodName = widget.foodName;
  late double showcarbs = widget.carbs;
  late double showfats = widget.fats;
  late double showproteins = widget.proteins;
  late double showfibers = widget.fibers;
  late double showcalories = widget.calories;

  final List<String> portionOptions = ['grama', 'kilo', 'miligrama'];
  String selectedPortion = 'grama';
  Refeicao? selectedRefeicao;
  final TextEditingController quantityController = TextEditingController();
  @override
  void initState() {
    super.initState();
    quantityController.addListener(updateValuesBasedOnQuantity);
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }
  void updateValuesBasedOnQuantity() {
    setState(() {
      // Obter a quantidade do controlador
      String quantityText = quantityController.text;
      print(quantityText);
      if(quantityText != '') {
        double quantity = double.tryParse(quantityText) ?? 100;

        // Criar novas variáveis locais para armazenar os cálculos
        double updatedCalories = widget.calories / 100 * quantity;
        double updatedProteins = widget.proteins / 100 * quantity;
        double updatedCarbs = widget.carbs / 100 * quantity;
        double updatedFibers = widget.fibers / 100 * quantity;
        double updatedFats = widget.fats / 100 * quantity;

        // Atualizar os valores exibidos na interface
        showcalories = updatedCalories;
        showproteins = updatedProteins;
        showcarbs = updatedCarbs;
        showfibers = updatedFibers;
        showfats = updatedFats;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Detalhes do Alimento',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.foodName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16,width: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextField(
                          controller: quantityController,
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Quantidade (g)',
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    // Adicione este código para o dropdown de refeições

                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black), // Adiciona a borda ao Container
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8), // Espaço à esquerda do TextField
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.number, // Permite apenas números
                          decoration: InputDecoration(
                            hintText: 'Refeições', // Adiciona um texto de dica
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none, // Remove a borda do TextField
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    FutureBuilder<dynamic>(
                      future: widget.refeicaoController.getrefeicoess(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Erro ao carregar refeições');
                        } else if (snapshot.hasData) {
                          List<Refeicao> refeicoes = snapshot.data!;
                          selectedRefeicao = refeicoes[0];
                          return DropdownButton<Refeicao>(
                            value: refeicoes.isNotEmpty ? selectedRefeicao : null,
                            onChanged: (Refeicao? newValue) {
                              setState(() {
                                selectedRefeicao = newValue;
                              });
                            },
                            icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            underline: Container(
                              height: 2,
                              color: Colors.black,
                            ),
                            items: refeicoes.map((Refeicao refeicao) {
                              return DropdownMenuItem<Refeicao>(
                                value: refeicao,
                                child: Text(refeicao.nome),
                              );
                            }).toList(),
                          );
                        } else {
                          return Text('Nenhuma refeição encontrada');
                        }
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),
              buildDetailRow('Calorias', showcalories.toStringAsFixed(2)),
              buildDetailRow('Proteínas (g)', showproteins.toStringAsFixed(2)),
              buildDetailRow('Carboidratos (g)', showcarbs.toStringAsFixed(2)),
              buildDetailRow('Fibras (g)', showfibers.toStringAsFixed(2)),
              buildDetailRow('Gorduras (g)', showfats.toStringAsFixed(2)),
              SizedBox(height: 16),
              Divider(),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  bool isFor = await widget.refeicaoController.alimentoOnRefeicoes(widget.id, selectedRefeicao!);

                  if (isFor) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Alimento adicionado com sucesso!'),
                        duration: Duration(seconds: 2),
                      ),
                    );

                    // Aguarde um pouco para que a mensagem seja exibida antes de voltar
                    await Future.delayed(Duration(seconds: 2));

                    // Navegar para a página anterior
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Erro ao adicionar alimento. Tente novamente.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  primary: Colors.blueGrey,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  'Adcionar',
                  style: TextStyle(
                    color: Colors.white,
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

  Widget buildDetailRow(String label, String value, {double fontSize = 16.0}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
