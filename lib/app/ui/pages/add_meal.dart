import 'package:flutter/material.dart';
import 'package:nutriped/app/ui/theme/design_system.dart';
import 'package:nutriped/app/ui/widgets/custom_button.dart';
import 'package:nutriped/app/ui/widgets/custom_text_form_field.dart';

class AddMeal extends StatefulWidget {
  const AddMeal({super.key});

  @override
  State<AddMeal> createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {
  TextEditingController meal = TextEditingController();

  int? groupValue = 0;
  int? selectedIndex;

  List<String> aux = [];
  List<String> foods = [
    'Café com leite',
    'Leite puro',
    'Achocolatado',
    'Pão salgado',
    'Pão doce',
    'Pão com manteiga',
    'Ovo frito',
    'Ovo cozido',
    'Biscoito doce',
    'Biscoito salgado',
    'Biscoito recheado',
    'Cereais',
    'Queijo',
    'Mortadela',
    'Cuscuz',
    'Beiju/Tapioca',
    'Batata doce',
    'Aipim/Macaxeira',
    'Geleia',
    'Bolo',
    'Bolo com cobertura',
    'Banana da terra cozida',
    'Banana da terra frita',
    'Suco da fruta natural',
    'Suco industrializado',
    'Feijão de caldo',
    'Feijão tropeiro',
    'Farinha',
    'Arroz',
    'Arroz integral',
    'Macarrão',
    'Macarrão integral',
    'Catchup',
    'Batata cozida',
    'Batata frita',
    'Purê de batata',
    'Carna bovina',
    'Carna bovina',
    'Frango',
    'Peixe',
    'Verduras/legumes',
    'Doce de sobremesa',
    'Fruta de sobremesa',
    'Sorvete',
    'Picolé',
    'Calabresa',
    'Sanduíche',
    'Hambúrguer',
    'Cachorro-quente',
    'Requeijão cremoso',
    'Queijo coalho',
    'Iogurte',
    'Lasanha',
    'Queijo tipo Ricota',
    'Torta doce',
    'Torta salgada',
    'Pizza salgada',
    'Pizza doce',
    'Fruta',
    'Salgadinho',
    'Bacon',
    'Mousse',
    'Pipoca doce',
    'Pipoca salgada',
    'Milho',
    'Pamonha',
    'Acarajé',
    'Vatapá',
    'Caruru',
  ];

  void search(String search) {
    aux = foods.where((element) => element.contains(search)).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: NutripedColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: NutripedColors.button,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Adicionar refeição',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    height: size.height * 0.4,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Material(
                  elevation: 3.0,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  child: Container(
                    height: size.height * 0.4,
                    width: size.width * 0.9,
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width * 0.7,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: Colors.black.withOpacity(0.05),
                                ),
                                child: CustomTextFormField(
                                  controller: meal,
                                  label: 'Pesquisar',
                                  noHaveLabel: true,
                                  onChanged: (String text) => setState(
                                    () => search(text),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.grey,
                                size: 32.0,
                              ),
                              onPressed: () {
                                meal.clear();
                                search('');
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        SizedBox(
                          height: size.height * 0.06,
                          width: size.width - 16.0,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(4.0),
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                meal.text.isEmpty ? foods.length : aux.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: index != 0 ? 8.0 : 0.0,
                                  ),
                                  child: Material(
                                    elevation: 1.0,
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: selectedIndex == index
                                            ? NutripedColors.button
                                            : Colors.yellow,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          meal.text.isEmpty
                                              ? foods[index]
                                              : aux[index],
                                          style: TextStyle(
                                            color: selectedIndex == index
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () => setState(
                                  () => selectedIndex = index,
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: size.width * 0.9,
                  child: CustomButton(
                    backgroundColor: NutripedColors.button,
                    text: 'Finalizar refeição',
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
