import 'package:flutter/material.dart';
import 'package:nutriped/app/data/models/meal_model.dart';
import 'package:nutriped/app/ui/theme/design_system.dart';
import 'package:nutriped/app/ui/widgets/food_item.dart';

class DetailsMeal extends StatelessWidget {
  final MealModel meal;

  const DetailsMeal({
    required this.meal,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: NutripedColors.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: NutripedColors.button,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: NutripedColors.background,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detalhes da refeição',
          style: TextStyle(color: NutripedColors.background),
        ),
      ),
      body: Center(
        child: Container(
          width: size.width * 0.9,
          height: size.height * 0.8,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: NutripedColors.itemBackGround,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: RichText(
                  text: TextSpan(
                    text:
                        '${meal.date.day.toString().padLeft(2, '0')}/${meal.date.month.toString().padLeft(2, '0')}/${meal.date.year}',
                    style: const TextStyle(
                      fontSize: 32.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text:
                            '  ${meal.date.hour.toString().padLeft(2, '0')}:${meal.date.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemCount: meal.foods.length,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.grey,
                      indent: 16.0,
                    );
                  },
                  itemBuilder: (context, index) {
                    String title = meal.foods.keys.elementAt(index);
                    String description = meal.foods.values.elementAt(index);

                    return FoodItem(
                      title: title,
                      description: description,
                      isWarning: false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
