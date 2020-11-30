import 'package:app_youtube/Biblioteca.dart';
import 'package:app_youtube/Emalta.dart';
import 'package:app_youtube/Inicio.dart';
import 'package:app_youtube/Inscricoes.dart';
import 'package:app_youtube/delagate.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _indiceAtual = 0;
  String resutado = " ";

  @override
  Widget build(BuildContext context) {
    List<Widget> telas = [
      Inicio(resutado),
      Emalta(),
      Biblioteca(),
      Inscricoes(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          "images/youtube.png",
          scale: 8,
        ),
        actions: [
          IconButton(
            color: Colors.grey,
            icon: Icon(Icons.search),
            onPressed: () async {
              String res =
                  await showSearch(context: context, delegate: Delegate());
              setState(() {
                resutado = res;
              });
              print(res);
            },
          ),
          /*
          IconButton(
              color: Colors.grey,
              icon: Icon(Icons.videocam),
              onPressed: () {
                print("Video");
              }),
          IconButton(
              color: Colors.grey,
              icon: Icon(Icons.account_circle),
              onPressed: () {
                print("Conta");
              }),*/
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        currentIndex: _indiceAtual,
        onTap: (indice) {
          setState(() {
            _indiceAtual = indice;
          });
        },
        items: [
          BottomNavigationBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.home,
              ),
              label: "Inicio"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.whatshot,
              ),
              label: "Em alta"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.folder,
              ),
              label: "Biblioteca"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.subscriptions,
              ),
              label: "Inscriçoes")
        ],
      ),
    );
  }
}
