
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/ui/widgets/filter_range_slider.dart';

import '../../utils/constants.dart';
import 'input_chips.dart';

class RecipeFilter extends StatelessWidget {
  const RecipeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      builder: (sheetContext, scrollController) => SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 5,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey),
                    ),
                  ),
                ),
                Text('Calories Range',
                    style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(
                  height: 10,
                ),
                const FilterRangeSlider(
                  filterName: CALORIES,
                  minValue: 0,
                  maxValue: 10000,
                  unit: 'Kcal',
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('Preparation Time',
                    style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(
                  height: 10,
                ),
                const FilterRangeSlider(
                  filterName: TOTAL_TIME,
                  minValue: 0,
                  maxValue: 300,
                  unit: 'Min',
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('Meal Type',
                    style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(
                  height: 10,
                ),
                const InputChips(
                  filters: MEAL_TYPES,
                  filterName: MEAL_TYPE,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('Dish Type',
                    style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(
                  height: 10,
                ),
                const InputChips(
                  filters: DISH_TYPES,
                  filterName: DISH_TYPE,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('Diet Types',
                    style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(
                  height: 10,
                ),
                const InputChips(
                  filters: DIET_LABELS,
                  filterName: DIET_TYPE,
                ),

              ],
            ),
          ),
        ),
        //meal type(single choice), diet(multiple choices),dish type(single choice),calories,total time,
      ),
    );
  }
}
