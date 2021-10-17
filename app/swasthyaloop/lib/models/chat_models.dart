import 'package:swasthyaloop/utils.dart';

class chat {
  final String name;
  String message;
  final String time;
  final String imageUrl;

  chat({this.name, this.message, this.time, this.imageUrl});
}

List<chat> messageData = [
  new chat(
      name: "Lilavati Hospital",
      message: "Ambulance is on the way.",
      time: "10:12",
      imageUrl: USER_IMAGE),
  new chat(
      name: "JJ hospital",
      message: "We have beds available",
      time: "02:16",
      imageUrl: USER_IMAGE),
  new chat(
      name: "Fortis",
      message: "Sorry, we don't entertain covid here.",
      time: "11:11",
      imageUrl: USER_IMAGE),
  new chat(
      name: "Lilavati Hospital",
      message: "Ambulance is on the way.",
      time: "10:12",
      imageUrl: USER_IMAGE),
  new chat(
      name: "JJ hospital",
      message: "We have beds available",
      time: "02:16",
      imageUrl: USER_IMAGE),
  new chat(
      name: "Harkishandas-Reliance",
      message: "Request for bed approved .",
      time: "20:21",
      imageUrl: USER_IMAGE),
  new chat(
      name: "Lilavati Hospital",
      message: "Ambulance is on the way.",
      time: "10:12",
      imageUrl: USER_IMAGE),
  new chat(
      name: "JJ hospital",
      message: "We have beds available",
      time: "02:16",
      imageUrl: USER_IMAGE),
  new chat(
      name: "Harkishandas-Reliance",
      message: "Request for bed approved .",
      time: "20:21",
      imageUrl: USER_IMAGE),
];
