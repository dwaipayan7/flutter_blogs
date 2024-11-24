import 'package:flutter/material.dart';
import 'package:flutter_blogs/core/theme/app_pallete.dart';
import 'package:flutter_blogs/feature/presentation/pages/login_page.dart';

import '../wigets/auth_field.dart';
import '../wigets/auth_gradient_button.dart';

class SignupPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context)=> SignupPage());
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();


}

class _SignupPageState extends State<SignupPage> {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    formKey.currentState?.validate();
    return  Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(padding: EdgeInsets.all(8),
          child: Icon(Icons.arrow_back_ios),
          ),
          
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Sign Up.", style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold
              ),),
              const SizedBox(height: 30,),
               AuthField(hintText: 'Name',controller: nameController,),
              const SizedBox(height: 15,),
               AuthField(hintText: 'Email', controller: emailController,),
              const SizedBox(height: 15,),
               AuthField(hintText: 'Password', controller: passwordController, isObscureText: true,),
              const SizedBox(height: 15,),
              const AuthGradientButton(buttonText: 'Sign In',),
              const SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, LoginPage.route());
                },
                child: RichText(
                    text: TextSpan(text: "Already have an account? ",
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
