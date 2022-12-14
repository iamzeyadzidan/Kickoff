import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:kickoff_frontend/application/application.dart';
import 'package:kickoff_frontend/application/screens/BuildComponentsPlayer.dart';
import 'package:kickoff_frontend/components/login/Email.dart';
import 'package:kickoff_frontend/components/login/PasswordPlayer.dart';
import 'package:kickoff_frontend/constants.dart';
import 'package:kickoff_frontend/localFile.dart';

import '../application/screens/announcements.dart';
import '../application/screens/player/player-reservations.dart';

class LoginButtonPlayer extends StatefulWidget {
  const LoginButtonPlayer({super.key});

  @override
  RoundedLogin createState() => RoundedLogin();
}

class RoundedLogin extends State<LoginButtonPlayer> {
  static final String _url = "http://${ip}:8080/login/player";
  static String url2 = "http://${ip}:8080/search/courtOwner/distance";

  static Future getCourtsinSearch(xAxis, yAxis) async {
    var res = await http.post(Uri.parse(url2),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "keyword": "",
          "xAxis": xAxis,
          "yAxis": yAxis, //TODO: make this dynamic
        }));
    print(res.body);
    // FieldValue arrayUnion(List<dynamic> elements) =>
    //     FieldValue._(FieldValueType.arrayUnion, elements);
    // courtsSearch= jsonDecode(res.body) as List<dynamic>;
    LoginScreen.courtsSearch = jsonDecode(res.body) as List<dynamic>;
    // print(courtsSearch);
    print("lol");
  }

  var resp = 52;
  late Map<String, dynamic> profileData;

  // static List<dynamic> courtsSearch=[];
  Future save(email, pass) async {
    var res = await http.post(Uri.parse(_url),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "email": email.toLowerCase(),
          "password": pass,
        }));
    // print(res.body);
    setState(() => profileData = json.decode(res.body));
  }

  static Future save2(email, pass) async {
    var res = await http.post(Uri.parse(_url),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "email": email.toLowerCase(),
          "password": pass,
        }));
    return json.decode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
        var Email = BuildLoginEmail.EmailLogin.text;
        var Password = Build_Password_Player.Password.text;
        if (Email.isEmpty) {
          showAlertDialog(context, 'Empty Email Address');
          BuildLoginEmail.EmailLogin.clear();
        } else if (Password.length < 6 ||
            Password.length > 15 ||
            Password.isEmpty) {
          showAlertDialog(context, 'Wrong Password');
          Build_Password_Player.Password.clear();
        } else {
          print(Build_Password_Player.Password.text);
          await save(BuildLoginEmail.EmailLogin.text,
              Build_Password_Player.Password.text);
          if (profileData.isEmpty) {
            showAlertDialog(context, 'Check your Information');
            BuildLoginEmail.EmailLogin.clear();
          } else if (profileData.length == 4) {
            showAlertDialog(context,
                'Wrong password password less than 4 character not accepted ');
            Build_Password_Player.Password.clear();
          } else {
            print(profileData);
            KickoffApplication.data = profileData;
            localFile.writeLoginData(BuildLoginEmail.EmailLogin.text,
                Build_Password_Player.Password.text, "1");
            KickoffApplication.player = true;

            BuildLoginEmail.EmailLogin.clear();
            Build_Password_Player.Password.clear();

            if (profileData["restricted"] == 'true') {
              FToast toast = FToast();
              toast.init(context);
              toast.showToast(
                toastDuration: const Duration(seconds: 6),
                gravity: ToastGravity.CENTER,
                child: customToast(
                    "Your account is restricted for ${profileData["penaltyDaysLeft"]} days due to receiving ${profileData["warnings"]} reports. You cannot book a reservation during this period."),
              );
            }
            KickoffApplication.playerId = "${profileData["id"]}";
            AnnouncementsHome.buildFullAnnouncements();
            PlayerReservationsHome.buildReservations();
            AnnouncementsHome.isExpanded = List<bool>.generate(
                AnnouncementsHome.announcements.length, (index) => false);
            print(AnnouncementsHome.announcements.length);
            await getCourtsinSearch(KickoffApplication.data["xAxis"],
                KickoffApplication.data["yAxis"]);
            KickoffApplication.setStartState();
            Navigator.popAndPushNamed(context, '/kickoff');
          }
        }
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: mainSwatch,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              blurRadius: 2,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        child: const Text(
          'Login',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context, text3) {
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: const Text("Alert!"),
            content: Text(text3),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ));
}
