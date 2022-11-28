import 'package:flutter/material.dart';
import 'package:kickoff_frontend/components/rounded_button.dart';
import 'package:kickoff_frontend/components/rounded_input.dart';
import 'package:kickoff_frontend/components/rounded_password_input.dart';


class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.defaultLoginSize,
  }) : super(key: key);

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isLogin ? 1.0 : 0.0,
      duration: animationDuration * 4,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: size.width,
          height: defaultLoginSize,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                  'Kickoff',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                  ),
                ),

                SizedBox(height: 40),

                Container(height:175 ,width:175,child: Image(image: AssetImage('assets/images/pic3.PNG'))),

                SizedBox(height: 40),

                RoundedInput(icon: Icons.mail, hint: 'Username'),

                RoundedPasswordInput(hint: 'Password'),

                SizedBox(height: 10),

                RoundedButton(title: 'LOGIN'),

                SizedBox(height: 10),

              ],
            ),
          ),
        ),
      ),
    );
  }
}