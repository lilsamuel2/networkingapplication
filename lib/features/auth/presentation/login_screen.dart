import 'package:flutter/material.dart';
import 'package:project/core/app_colors.dart';
import 'package:project/widgets/custom_button.dart';
import 'package:project/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.lightGray,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              Text(
                'Login Screen',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryBlue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              const CustomTextField(hintText: 'Username'),
              const SizedBox(height: 20),
              const CustomTextField(hintText: 'Password'),
              const SizedBox(height: 30),
              CustomButton(
                text: 'Log in',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}