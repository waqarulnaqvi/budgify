import 'package:budgify/core/constants/static_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodel/theme_controller.dart';

class ThemeControllerWidget extends ConsumerWidget {
  const ThemeControllerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsyncValue = ref.watch(isLightThemeProvider);
    final provider = ref.read(isLightThemeProvider.notifier);

    return themeAsyncValue.when(
      data: (isLightTheme) {
        return InkWell(
          onTap: () {
            isLightTheme
                ? provider.setFilter(false)
                : provider.setFilter(true);
          },
          child: Card(
            elevation: 4,
            margin: EdgeInsets.all(10.0),
            shape: const CircleBorder(),
            child: Container(
              padding: const EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Image(
                image: AssetImage(
                  isLightTheme
                      ? StaticAssets.darkTheme
                      : StaticAssets.lightTheme,
                ),
                width: 23,
                height: 23,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        );
      },
      loading: () => const SizedBox(
        height: 40,
        width: 40,
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => const Icon(Icons.error),
    );
  }
}
