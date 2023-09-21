import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tech_task/widgets/app_input_field.dart';
import '../route_handler.dart';
import '../widgets/app_button.dart';
import '../widgets/app_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController dateTC = TextEditingController();
  DateTime selectDate = DateTime.now();

  @override
  void initState() {
    setState(() {
      dateTC.text = DateFormat('dd MMM, yyyy').format(selectDate);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hasBackButton: false,
      appBarTitle: 'Home',
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Text('Please select date', style: Theme.of(context).textTheme.titleLarge,),
                ),
                InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                      initialDatePickerMode: DatePickerMode.year
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectDate = pickedDate;
                        dateTC.text = DateFormat('dd MMM, yyyy').format(pickedDate);
                      });
                    }
                  },
                  child: AppInputField(
                    label: 'Date',
                    hintText: 'Date',
                    enabled: false,
                    controller: dateTC,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AppPrimaryButton(
              label: 'Get Ingredients',
              onTap: (){
                Navigator.pushNamed(context, RouteHandler.ingredients, arguments: selectDate);
              }
          ),
        ),
      ),
    );
  }
}