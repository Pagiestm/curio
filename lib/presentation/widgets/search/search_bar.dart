import 'dart:async';
import 'package:curio/l10n/app_localizations.dart';
import 'package:curio/presentation/viewmodels/search_viewmodel.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final SearchViewmodel vm;

  const CustomSearchBar({super.key, required this.vm});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController controller = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    controller.text = widget.vm.searchKeyword ?? '';
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    // Annule le timer précédent si on retape avant la fin
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Redémarre un timer de 500ms
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.vm.setSearchKeyword(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: theme.colorScheme.onSurface),
        decoration: InputDecoration(
          hintText: l10n.searchHint,
          hintStyle: TextStyle(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          prefixIcon: Icon(Icons.search, color: theme.colorScheme.primary),
          suffixIcon: widget.vm.searchLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                )
              : controller.text.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    controller.clear();
                    widget.vm.setSearchKeyword('');
                  },
                  child: Icon(Icons.clear, color: theme.colorScheme.primary),
                )
              : null,
          filled: true,
          fillColor: theme.colorScheme.surface,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        textInputAction: TextInputAction.search,
        onChanged: (value) => _onSearchChanged(value),
      ),
    );
  }
}
