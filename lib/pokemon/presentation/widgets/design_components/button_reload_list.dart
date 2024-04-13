import 'package:flutter/material.dart';

class ReloadButton extends StatelessWidget {
  final VoidCallback onReload;

  const ReloadButton({super.key, required this.onReload});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onReload,
      tooltip: 'Reload Pokémon List',
      backgroundColor: Colors.red,
      child: const Icon(Icons.refresh, color: Colors.white),
    );
  }
}
