import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/core/utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        title: const Text('Onxy IX POS'),
        actions: [
                IconButton(
            icon: const Icon(Icons.language),   
            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(Icons.dark_mode),   
            onPressed: () {
            },
          ),
      
        ],
      ),
    );
  }
}