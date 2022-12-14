import 'package:flutter/material.dart';
import 'package:kickoff_frontend/components/login/PasswordPlayer.dart';
import 'package:kickoff_frontend/httpshandlers/loginrequestsplayer.dart';
import '../../constants.dart';
import 'Email.dart';


class BuildLoginFormPlayer extends StatelessWidget {
  const BuildLoginFormPlayer({
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
                const Text(
                  'Player',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(height: 40),
                Container(
                    height: 175,
                    width: 175,
                    child: const Image(
                        image: AssetImage('assets/images/player.png'))),
                SizedBox(height: 40),
                BuildLoginEmail(icon: Icons.mail,color: mainSwatch, hint: 'Email Address'),
                PasswordLoginPlayer(),
                SizedBox(height: 10),
                LoginButtonPlayer(),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
