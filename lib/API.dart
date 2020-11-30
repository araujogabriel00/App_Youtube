import 'dart:convert';
import 'package:app_youtube/models/Video.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

const URL_BASE = "https://www.googleapis.com/youtube/v3/";
const CHAVE_API = "AIzaSyB7SFn6l9MJaugILrVGWBWa8UORtbbc4-4";
const ID_CANAL = "UCfI1IZkpGIbL6H555FSFOLw";

class Api {
  Future<List<Video>> pesquisar(String pesquisa) async {
    http.Response response = await http.get(URL_BASE +
        "search"
            "?part=snippet"
            "&type=video"
            "&maxResults=20"
            "&order=date"
            "&key=$CHAVE_API"
            "&channelId=$ID_CANAL"
            "&q=$pesquisa");

    if (response.statusCode == 200) {
      Map<String, dynamic> dadosJson = jsonDecode(response.body);

      List<Video> videos = dadosJson["items"].map<Video>((map) {
        return Video.fromJson(map);

        //return Video.converterJson(map);
      }).toList();

      return videos;

      /* for (var videos in dadosJson["items"]) {
        print("resultado: " + videos.toString());
      }*/

      ///print("Resul:" + dadosJson["items"][3]["snippet"]["title"].toString());
    } else {
      print("Errado");
    }
  }
}
