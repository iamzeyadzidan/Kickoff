import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

import '../application/application.dart';
import '../components/classes/Party.dart';
import '../components/classes/partyPlayer.dart';

class PartiesHTTPsHandler {
  static final String _url = "http://${KickoffApplication.userIP}:8080";
  static Future<bool> createParty(Rid , empty , full) async {
    var response = await http.post(
        Uri.parse('$_url/party/createparty'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "reservationId": Rid,
          "emptyplaces": empty,
          "fullplaces": full,
        }));
    print(response.body);
    return(json.decode(response.body));
  }

  static Future<List<Party>>  Partyappear(Coid) async {
    var response = await http.post(
        Uri.parse('$_url/party/parties_appear_courtowner'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "id": Coid,
        }));
    print(response.body);
    List<dynamic> temp = json.decode(response.body);
    List<Party> parties = convertIntoList(temp);
    return parties;
  }
  static List<Party> convertIntoList(temp){
    Party party;
    List<Party> parties = <Party>[];
    for (Map<String, dynamic> map in temp) {
      party = Party();
      party.id = map['id'].toString();
      party.COname = map['COname'].toString();
      party.Cname = map['Cname'].toString();
      party.Pname = map['Pname'].toString();
      if (map.containsKey('Pimg')) {
        party.Pimg = map['Pimg'].toString();
      }
      party.Date = map['Date'].toString();
      party.timeFrom = map['timeFrom'].toString().substring(0,(map['timeFrom'].toString().lastIndexOf(":")));
      party.timeTo = map['timeTo'].toString().substring(0,(map['timeTo'].toString().lastIndexOf(":")));
      party.emptyplaces = map['emptyplaces'].toString();
      party.fullplaces = map['fullplaces'].toString();
      party.totalCost = map['totalCost'];
      parties.add(party);
    }
    return parties;
  }

  static Future<List<Party>> getPartiesCourtOwner(coid,pid) async {
    var response = await http.post(
        Uri.parse('$_url/party/get_parties_of_courtOwner'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "id": coid,
          "pid":pid
        }));
    print(response.body);
    List<dynamic> temp = json.decode(response.body);
    List<Party> parties = convertIntoList(temp);
    return parties;
  }

  static Future<List<Party>> getPartiesCreated(pid) async {
    var response = await http.post(
        Uri.parse('$_url/party/get_parties_created_by_player'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "id": pid,
        }));
    print(response.body);
    List<dynamic> temp = json.decode(response.body);
    List<Party> parties = convertIntoList(temp);
    return parties;
  }

  static Future<List<Party>> getPartiesJoined(pid) async {
    var response = await http.post(
        Uri.parse('$_url/party/get_parties_joined_by_player'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "id": pid,
        }));
    print(response.body);
    List<dynamic> temp = json.decode(response.body);
    List<Party> parties = convertIntoList(temp);
    return parties;
  }
  static Future<List<Party>> getPartiesSubscribedNotJoined(pid) async {
    var response = await http.post(
        Uri.parse('$_url/party/get_parties_subscribed_not_join'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "id": pid,
        }));
    print(response.body);
    List<dynamic> temp = json.decode(response.body);
    List<Party> parties = convertIntoList(temp);
    return parties;
  }

  static Future<List<PartyPlayer>> getPlayersJoinedParty(partyId) async {
    var response = await http.post(
        Uri.parse('$_url/party/get_player_joined_by_parties'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "id": partyId.toString(),
        }));
    print(response.body);
    List<dynamic> temp = json.decode(response.body);
    List<PartyPlayer> players = <PartyPlayer>[];
    PartyPlayer player;
    for (Map<String, dynamic> map in temp) {
      player = PartyPlayer();
      player.pid = map['id'].toString();
      player.Pname = map['name'].toString();
      if (map.containsKey('image')) {
        player.Pimg = map['image'].toString();
      }
      players.add(player);
    }
    return players;
  }

  static Future joinParty(PartyID,pid) async {
    var response = await http.post(
        Uri.parse(
            '$_url/party/joinparty'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "id": PartyID,
          "pid": pid,
        }));
    print(response.body);
  }

  static Future leaveParty(PartyID,pid) async {
    var response = await http.post(
        Uri.parse(
            '$_url/party/leaveparty'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "id": PartyID,
          "pid": pid,
        }));
    print(response.body);
  }

  static Future deleteParty(PartyID) async {
    var response = await http.post(
        Uri.parse(
            '$_url/party/deleteparty'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "id": PartyID,
        }));
    print(response.body);
  }
}
