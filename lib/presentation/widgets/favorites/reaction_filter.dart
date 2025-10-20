import 'dart:math';

import 'package:curio/domain/entities/favorite.dart';
import 'package:curio/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ReactionFilter extends StatelessWidget {
  final ReactionType? selectedReaction;
  final Function(ReactionType?) onReactionSelected;
  final VoidCallback onClearFilter;

  const ReactionFilter({
    super.key,
    required this.selectedReaction,
    required this.onReactionSelected,
    required this.onClearFilter,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.filterByReaction,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              if (selectedReaction != null)
                TextButton(
                  onPressed: onClearFilter,
                  child: Text(
                    l10n.seeAll,
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...ReactionType.values.map((reaction) {
                  final isSelected = selectedReaction == reaction;
                  return GestureDetector(
                    onTap: () =>
                        onReactionSelected(isSelected ? null : reaction),
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? theme.colorScheme.primaryContainer
                            : theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(20),
                        border: isSelected
                            ? Border.all(
                                color: theme.colorScheme.primary,
                                width: 2,
                              )
                            : null,
                      ),
                      child: Row(
                        children: [
                          Text(
                            reaction.emoji,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _getReactionLabel(reaction, context),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              color: isSelected
                                  ? theme.colorScheme.onPrimaryContainer
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getReactionLabel(ReactionType reaction, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (reaction) {
      case ReactionType.sad:
        return l10n.sad;
      case ReactionType.angry:
        return l10n.angry;
      case ReactionType.happy:
        return l10n.happy;
      case ReactionType.funny:
        return l10n.funny;
    }
  }
}
