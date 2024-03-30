
import 'package:flutter/material.dart';

const String MEAL_TYPE = 'mealType';
const String DISH_TYPE = 'dishType';
const String DIET_TYPE = 'diet';
const String CALORIES = 'calories';
const String TOTAL_TIME = 'time';
const String DEFAULT_QUERY = 'chicken';
const Map<String,dynamic> DEFAULT_FILTERS = {MEAL_TYPE:'',DISH_TYPE:'',CALORIES:RangeValues(0, 10000),TOTAL_TIME:RangeValues(0, 300)};
const List<String> DISH_TYPES = [
  "Biscuits and Cookies",
  "Bread",
  "Cereals",
  "Condiments and Sauces",
  "Desserts",
  "Drinks",
  "Egg",
  "Ice Cream and Custard",
  "Main Course",
  "Pancake",
  "Pasta",
  "Pastry",
  "Pies and Tarts",
  "Pizza",
  "Preps",
  "Preserves",
  "Salad",
  "Sandwiches",
  "Seafood",
  "Side Dish",
  "Soup",
  "Special Occasions",
  "Starter",
  "Sweets",
];
const List<String> CUISINE_TYPES = [
  "American",
  "Asian",
  "British",
  "Caribbean",
  "Central Europe",
  "Chinese",
  "Eastern Europe",
  "French",
  "Greek",
  "Indian",
  "Italian",
  "Japanese",
  "Korean",
  "Kosher",
  "Mediterranean",
  "Mexican",
  "Middle Eastern",
  "Nordic",
  "South American",
  "South East Asian",
  "World",
];
const List<String> DIET_LABELS = [
  "Balanced",
  "High-Fiber",
  "High-Protein",
  "Low-Carb",
  "Low-Fat",
  "Low-Sodium",
];
const List<String> MEAL_TYPES = [
  "Breakfast",
  "Lunch",
  "Dinner",
  "Snack",
  "Teatime",
];
