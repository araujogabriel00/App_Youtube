import 'package:app_youtube/API.dart';
import 'package:app_youtube/models/Video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class Inicio extends StatefulWidget {
  String pesquisa;

  Inicio(this.pesquisa);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  _listarVideos(String pesquisa) {
    Future<List<Video>> videos;
    Api api = Api();

    return api.pesquisar(pesquisa);
  }

  @override
  void initState() {
    super.initState();
    print("1 - InitState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("2 - didChangeDependencies");
  }

  @override
  void dispose() {
    super.dispose();
    print("4 - dispose");
  }

  @override
  Widget build(BuildContext context) {
    print("3 - build");
    return FutureBuilder<List<Video>>(
        future: _listarVideos(widget.pesquisa),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.done:
            case ConnectionState.active:
              if (snapshot.hasData) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      List<Video> videos = snapshot.data;
                      Video video1 = videos[index];

                      return GestureDetector(
                        onTap: () {
                          FlutterYoutube.playYoutubeVideoById(
                              apiKey: CHAVE_API,
                              videoId: video1.id,
                              autoPlay: true,
                              fullScreen: true);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(video1.imagem))),
                            ),
                            ListTile(
                              title: Text(video1.titulo),
                              subtitle: Text(video1.descricao),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                          height: 2,
                          color: Colors.black,
                        ),
                    itemCount: snapshot.data.length);
              } else {
                return Center(
                  child: Text("Deu ruim"),
                );
              }
              break;
          }
        });
  }
}
