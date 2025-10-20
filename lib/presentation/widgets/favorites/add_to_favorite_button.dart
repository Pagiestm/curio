import 'package:curio/domain/entities/article.dart';
import 'package:curio/domain/entities/favorite.dart';
import 'package:curio/l10n/app_localizations.dart';
import 'package:curio/presentation/viewmodels/favorite_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToFavoriteButton extends StatefulWidget {
  final Article article;

  const AddToFavoriteButton({super.key, required this.article});

  @override
  State<AddToFavoriteButton> createState() => _AddToFavoriteButtonState();
}

class _AddToFavoriteButtonState extends State<AddToFavoriteButton> {
  bool _isFavorite = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  @override
  void didUpdateWidget(AddToFavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Si l'article a changé, on recharge le statut du favori
    if (oldWidget.article.id != widget.article.id) {
      _checkFavoriteStatus();
    }
  }

  Future<void> _checkFavoriteStatus() async {
    setState(() {
      _isLoading = true;
    });

    final vm = context.read<FavoriteViewmodel>();
    final isFav = await vm.isFavorite(widget.article.id);
    if (mounted) {
      setState(() {
        _isFavorite = isFav;
        _isLoading = false;
      });
    }
  }

  void _showReactionDialog() {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        title: Text(
          l10n.chooseReaction,
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ReactionType.values.map((reaction) {
            return ListTile(
              leading: Text(
                reaction.emoji,
                style: const TextStyle(fontSize: 24),
              ),
              title: Text(
                _getReactionLabel(reaction, context),
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
              onTap: () {
                Navigator.of(context).pop();
                _addToFavorite(reaction);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> _addToFavorite(ReactionType reaction) async {
    final vm = context.read<FavoriteViewmodel>();
    await vm.addFavorite(widget.article, reaction);
    if (mounted) {
      setState(() {
        _isFavorite = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Ajouté aux favoris'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _removeFromFavorite() async {
    final vm = context.read<FavoriteViewmodel>();
    await vm.removeFavoriteByArticleId(widget.article.id);
    final l10n = AppLocalizations.of(context)!;
    if (mounted) {
      setState(() {
        _isFavorite = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.removeFromFavorites),
          backgroundColor: Theme.of(context).colorScheme.error,
          duration: const Duration(seconds: 2),
        ),
      );
    }
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return IconButton(
        icon: const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        onPressed: null,
      );
    }

    return IconButton(
      icon: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        color: _isFavorite ? Colors.red : theme.colorScheme.onSurface,
      ),
      onPressed: () {
        if (_isFavorite) {
          _removeFromFavorite();
        } else {
          _showReactionDialog();
        }
      },
    );
  }
}
