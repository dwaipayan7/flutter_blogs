import 'package:flutter/material.dart';
import 'package:flutter_blogs/core/theme/app_pallete.dart';
import 'package:flutter_blogs/feature/auth/presentation/pages/signup_page.dart';


import '../wigets/auth_field.dart';
import '../wigets/auth_gradient_button.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => LoginPage());
   const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    formKey.currentState?.validate();
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Sign In.", style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold
              ),),
              const SizedBox(height: 30,),
              AuthField(hintText: 'Email', controller: emailController,),
              const SizedBox(height: 15,),
              AuthField(hintText: 'Password', controller: passwordController, isObscureText: true,),
              const SizedBox(height: 15,),
              const AuthGradientButton(buttonText: 'Sign In',),
              const SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      SignupPage.route()
                      );
                },
                child: RichText(
                  text: TextSpan(text: "Don't have an account? ",
                      style: Theme.of(context).textTheme.titleMedium,

                      children: [
                        TextSpan(
                            text: "Sign Up",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppPallete.gradient1,
                                fontWeight: FontWeight.bold
                            )
                        )
                      ]
                  ),

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
