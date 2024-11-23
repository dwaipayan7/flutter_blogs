
import 'package:flutter/material.dart';
import 'package:flutter_blogs/core/theme/app_pallete.dart';

class AuthGradientButton extends StatelessWidget {
  const AuthGradientButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              AppPallete.gradient1,
              AppPallete.gradient2
            ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight
        ),
        borderRadius: BorderRadius.circular(7)
      ),
      child: ElevatedButton(
          onPressed: (){},
          child: Text("Sign Up",
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),),
        style: ElevatedButton.styleFrom(
          fixedSize: Size(390, 55),
          backgroundColor: AppPallete.transparentColor,
            shadowColor: AppPallete.transparentColor

        ),
      ),
    );
  }
}
