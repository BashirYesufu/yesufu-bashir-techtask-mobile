import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tech_task/bloc/ingredient_bloc.dart';
import 'package:tech_task/route_handler.dart';
import 'package:tech_task/utilities/ui_actions.dart';
import 'package:tech_task/widgets/app_button.dart';
import 'package:tech_task/widgets/app_scaffold.dart';
import '../constants/color_path.dart';
import '../models/ingredient.dart';
import '../widgets/custom_checkbox.dart';

class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({required this.date, Key? key}) : super(key: key);
  final DateTime date;

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  IngredientBloc _ingredientBloc = IngredientBloc();
  List<String> selectedIngredients = [];
  List<bool> checkValue = [];
  bool get isDark  => Theme.of(context).brightness == Brightness.dark;

  @override
  void initState() {
    _ingredientBloc.fetchIngredients();

    _ingredientBloc.ingredientsResponse.listen((ingredients) {
      for(var _ in ingredients) {
        checkValue.add(false);
      }
    }, onError: (error) {
      UIActions.showError(context, error);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      loadingStream: _ingredientBloc.progressObservable,
      appBarTitle: '${DateFormat('dd MMM, yyyy').format(widget.date)}',
      body: SafeArea(
        child: StreamBuilder(
          stream: _ingredientBloc.ingredientsResponse,
          builder: (context, AsyncSnapshot<List<Ingredient>> indexSnapshot) {
            if (indexSnapshot.hasError) {
              return Text(indexSnapshot.error.toString());
            }
            if (indexSnapshot.hasData && indexSnapshot.data?.isNotEmpty == true) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child:  ListView.builder(
                  itemCount: indexSnapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          indexSnapshot.data![index].title,
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Expires ${DateFormat('dd MMM, yyyy').format(indexSnapshot.data![index].useBy)}',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            widget.date.isAfter(indexSnapshot.data![index].useBy) ? SizedBox() : CustomCheckBox(
                              value: checkValue[index],
                              shouldShowBorder: checkValue[index],
                              splashColor: ColorPath.blue.withOpacity(0.4),
                              checkedIconColor: isDark ? ColorPath.fieldPlaceHolder : Colors.white,
                              checkedFillColor: ColorPath.blue,
                              uncheckedFillColor: isDark ? ColorPath.fieldBorderDark: Colors.white,
                              uncheckedIconColor: isDark ? ColorPath.fieldBorderDark: Colors.white,
                              checkBoxSize: 20,
                              borderColor: checkValue[index]
                                  ? Colors.black
                                  : isDark
                                  ? ColorPath.fieldBorderDark
                                  : ColorPath.fieldBorderLight,
                              borderWidth: 2,
                              tooltip: 'Custom Check Box',
                              splashRadius: 10,
                              onChanged: (val) {
                                if(val) {
                                  selectedIngredients.add(indexSnapshot.data![index].title);
                                } else {
                                  selectedIngredients.remove(indexSnapshot.data![index].title);
                                }
                                setState(() {
                                  checkValue[index] = val;
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    }
                ),
              );
            }
            if (indexSnapshot.hasData && indexSnapshot.data?.isEmpty == true) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // SvgPicture.asset(ImagePath.createCard),
                      Text(
                        'Looks like you have no ingredients in yur fridge',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              );
            }
            else {
              return SizedBox();
            }
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AppPrimaryButton(
            label: 'Get Recipes',
            onTap: (){
              if (selectedIngredients.isEmpty){
                UIActions.showError(context, 'Kindly select at least one ingredient');
                return;
              }
              Navigator.pushNamed(context, RouteHandler.recipes, arguments:  selectedIngredients);
            }
          ),
        ),
      ),
    );
  }


}
