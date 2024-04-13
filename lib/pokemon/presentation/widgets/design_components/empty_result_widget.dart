import 'package:flutter/material.dart';

class EmptyResultWidget extends StatelessWidget {
  const EmptyResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No result found'),
    );
  }
}
