import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ppbl2026/data/Album.dart';

Future<int> hapusAlbum() async{
  return 1;
}

Future<int> tambahAlbum() async{
  return 1;
}

Future<List<Album>> fetchAlbum() async {
  List<Album> albums = [];
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/'));

  print(response.statusCode);
  if (response.statusCode == 200 || response.statusCode == 304) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final list = jsonDecode(response.body);
    for(var data in list){
      albums.add(Album.fromJson(data));
    }
    return albums;
    //return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}