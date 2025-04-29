import 'package:flutter/material.dart';
import 'package:mobile_app/core/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;

  const CustomButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(      
      onPressed: () {}, 
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), 
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: AppColors.white),
      ),
    );
  }
}