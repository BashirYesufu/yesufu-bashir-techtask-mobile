import 'package:flutter/material.dart';
import 'package:tech_task/constants/color_path.dart';
import 'package:tech_task/route_handler.dart';
import '../widgets/app_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hasBackButton: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Text('Please select meal', style: Theme.of(context).textTheme.titleLarge,),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildMeal('Breakfast'),
                  buildMeal('Lunch'),
                ],
              ),
              buildMeal('Dinner'),
            ],
          ),
        ),
      ),
    );
  }

  InkWell buildMeal(String meal) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteHandler.ingredients, arguments: meal);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Text(meal, style: Theme
              .of(context)
              .textTheme
              .titleMedium,),
        ),
        color: ColorPath.blue,
      ),
    );
  }
}