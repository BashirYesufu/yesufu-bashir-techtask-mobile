import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_task/utilities/providers/app_providers.dart';
import 'package:tech_task/utilities/theme_manager.dart';
import 'package:tech_task/widgets/app_scaffold.dart';
import '../constants/color_path.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarTitle: 'Settings',
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final theme = ref.read(AppProviders.themeProvider);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text('Theme', style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                _buildOptions(
                  title: 'System',
                  selected: theme.theme == AppTheme.SYSTEM,
                  onTap: ()=> theme.setThemeMode(AppTheme.SYSTEM),
                ),
                _buildOptions(
                  title: 'Light Theme',
                  selected: theme.theme == AppTheme.LIGHT,
                  onTap: ()=> theme.setThemeMode(AppTheme.LIGHT),
                ),
                _buildOptions(
                  title: 'Dark Theme',
                  selected: theme.theme == AppTheme.DARK,
                  onTap: ()=> theme.setThemeMode(AppTheme.DARK),
                ),
              ],
            );
          }),
        )

      ),
    );
  }
  Widget _buildOptions({
    required String title,
    required bool selected,
    required Function() onTap
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
          selected ? Icon(Icons.check, color: ColorPath.blue) : SizedBox()
        ],
      ),
    );
  }

}
