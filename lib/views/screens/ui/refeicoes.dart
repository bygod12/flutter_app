import 'package:flutter/material.dart';
import 'package:untitled1/controllers/refeicoesController.dart';

import '../login/Animation/FadeAnimation.dart';
import 'detalhes_alimentos.dart';



class ListRefeicoes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Define a cor de fundo da AppBar como branca
        title: Text(
          'Café da manhã',
          style: TextStyle(
            color: Colors.black, // Define a cor do texto como preto
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black, // Define a cor do ícone como preto
          ),
          onPressed: () {
            Navigator.pop(context); // Isso irá desempilhar a página atual e voltar para a página anterior
          },
        ),
      ),
      body: Container(
        color: Color(0xFFF2F3F8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 16),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],

                  ),
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      FoodListItem(
                        name: 'Maçã',
                        calories: 52,
                      ),
                      FoodListItem(
                        name: 'Banana',
                        calories: 96,
                      ),
                      FoodListItem(
                        name: 'Cenoura',
                        calories: 41,
                      ),
                      FoodListItem(
                        name: 'Uva',
                        calories: 69,
                      ),
                      FoodListItem(
                        name: 'Laranja',
                        calories: 43,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodListItem extends StatelessWidget {
  final String name;
  final int calories;

  const FoodListItem({
    Key? key,
    required this.name,
    required this.calories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return FadeAnimation(1.9, InkWell(
      onTap: () {
        // Adicione a ação que deseja realizar quando o AnimatedBuilder for clicado.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodDetailsScreen(
              refeicaoController: new RefeicaoController(),
              id: 1,
              foodName: 'Maçã',
              carbs: 14,
              fats: 1,
              proteins: 2,
              fibers: 3,
              calories: 4,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '$calories calorias',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    ));
  }
}
