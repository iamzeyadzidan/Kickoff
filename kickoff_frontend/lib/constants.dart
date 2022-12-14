import 'package:flutter/material.dart';
import 'package:kickoff_frontend/application/application.dart';

MaterialColor mainSwatch = KickoffApplication.player ? playerColor : courtOwnerColor;
const playerColor = Colors.green;
const courtOwnerColor = Colors.cyan;
const secondaryColor = Colors.white;
const alternativeColor = Colors.black87;
const ip = "192.168.49.226";

customToast(text) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(25.0),
    color: mainSwatch,
  ),
  child: Text(
    text,
    style: const TextStyle(color: secondaryColor),
  ),
);

getIP() => ip;
