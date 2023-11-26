import 'package:flutter/material.dart';
import 'package:untitled1/controllers/refeicoesController.dart';
import 'package:untitled1/models/alimento.dart';

import '../../login/Animation/FadeAnimation.dart';
import '../cadastrar_alimento.dart';
import '../detalhes_alimentos.dart';
import '../fitness_app_home_screen.dart';

class FoodSearchScreen extends StatefulWidget {
  final List<Alimento> alimentos;
  final RefeicaoController refeicaoController;

  FoodSearchScreen({
    Key? key,
    required this.alimentos,
    required this.refeicaoController,

  }) : super(key: key);

  @override
  _FoodSearchScreenState createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends State<FoodSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Alimento> filteredAlimentos = [];

  @override
  void initState() {
    super.initState();
    // Inicializar a lista filtrada com a lista completa de alimentos
    filteredAlimentos = widget.alimentos;
  }

  void _filterAlimentos() {
    setState(() {
      filteredAlimentos = widget.alimentos
          .where((alimento) => alimento.nome
          .toLowerCase()
          .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: SingleChildScrollView(
          child: Container(
            color: Color(0xFFF2F3F8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  FadeAnimation(
                    1.9,
                    TextFormField(
                      controller: _searchController,
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        _filterAlimentos();
                      },
                      decoration: InputDecoration(
                        hintText: 'Digite o nome do alimento',
                        hintStyle: TextStyle(color: Colors.black54),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.food_bank, color: Colors.black),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 400,
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
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredAlimentos.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Alimento alimento = filteredAlimentos[index];
                        return FoodListItem(
                          alimento: alimento,
                          name: alimento.nome,
                          calories: alimento.calorias,
                          refeicaoController: widget.refeicaoController!,

                        );
                      },
                    ),
                  ),
                  SizedBox(height: 60),
                  FadeAnimation(
                    1.6,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  FoodAddScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          primary: Colors.blueGrey,
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Cadastrar alimento',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  FadeAnimation(
                    1.6,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  FoodAddScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          primary: Colors.blueGrey,
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Adcionar um aliumento',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class FoodListItem extends StatelessWidget {
  final String name;
  final double calories;
  final Alimento alimento;
  final RefeicaoController refeicaoController;

  const FoodListItem({
    Key? key,
    required this.alimento,
    required this.name,
    required this.calories,
    required this.refeicaoController,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return FadeAnimation(1.9, Container(
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
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodDetailsScreen(
                    id: alimento.id,
                    foodName: alimento.nome,
                    carbs: alimento.carboidratos,
                    fats: alimento.gorduras,
                    proteins: alimento.proteinas,
                    fibers: alimento.fibras,
                    calories: alimento.calorias,
                    refeicaoController: refeicaoController,

                  ),
                ),
              );
            },
          ),
        ],
      ),
    ));
  }
}
