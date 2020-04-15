import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:music_list/model/get_music_list_data.dart';
import 'package:music_list/reusable_views/album_view.dart';
import 'package:url_launcher/url_launcher.dart';

class AlbumDetailsScreen extends StatefulWidget {
  final AlbumDetails details;

  const AlbumDetailsScreen({Key key, this.details}) : super(key: key);

  @override
  _AlbumDetailsScreenState createState() => _AlbumDetailsScreenState(details: details);
}

class _AlbumDetailsScreenState extends State<AlbumDetailsScreen> {
  final AlbumDetails details;

  _AlbumDetailsScreenState({this.details});

  String releaseDate;
  String genres;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    releaseDate = new DateFormat("dd MMMM yyyy").format(details.releaseDate);
    genres = "";
    for (int i = 0; i < details.genres.length; i++) {
      if (i == details.genres.length - 1) {
        genres = "$genres ${details.genres[i].name}";
      } else {
        genres = "$genres ${details.genres[i].name}, ";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Detail Page"),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Center(
                child: Hero(
                  tag: "hero_${details.artistId}",
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      details.artworkUrl100,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                details.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                details.artistName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Table(
                children: <TableRow>[
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Released On',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          releaseDate,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Genres',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          genres,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: RaisedButton(
                            onPressed: () async {
                              if (await canLaunch(details.url)) {
                                launch(details.url);
                              }
                            },
                            child: Text('View Album Info'),
                          )),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: RaisedButton(
                          onPressed: () async {
                            if (await canLaunch(details.artistUrl)) {
                              launch(details.artistUrl);
                            }
                          },
                          child: Text('View Artist Info'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
