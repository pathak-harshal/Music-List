import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_list/model/get_music_list_data.dart';
import 'package:music_list/reusable_views/album_view.dart';
import 'package:music_list/screens/album_details_screen.dart';
import 'package:music_list/util/show_dialogs.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AlbumDetails> mainList = List<AlbumDetails>();
  List<AlbumDetails> listToShow = List<AlbumDetails>();

  String query = "";

  TextEditingController searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: new Scaffold(
        appBar: new AppBar(
          title: Text('Music Albums'),
        ),
        body: Container(
          child: FutureBuilder<List<AlbumDetails>>(
            future: getAlbumsFromAPI(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.data == null) {
                return ShowDialogs.showLoader('Loading, Please Wait...');
              } else {
                if (snapshot.data.isEmpty) {
                  return emptyListMessageView();
                } else {
                  return albumListWithSearch(snapshot.data);
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget emptyListMessageView() {
    return Container(
      alignment: Alignment.center,
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('No Album Available'),
          RaisedButton(
            onPressed: () {
              setState(() {});
              getAlbumsFromAPI();
            },
            child: Text('Reload'),
          )
        ],
      ),
    );
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      setState(() {
        listToShow = mainList.where((album) => album.artistName.toLowerCase().contains(query.toLowerCase()) || album.name.toLowerCase().contains(query.toLowerCase())).toList();
      });
    } else {
      setState(() {
        listToShow = mainList;
      });
    }
  }

  Widget albumListWithSearch(List<AlbumDetails> list) {
    return Container(
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchEditingController,
              autocorrect: false,
              onChanged: (text) {
                setState(() {
                  query = searchEditingController.text;
                });
              },
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return query.isEmpty
                    ? GestureDetector(
                        onTap: () {
                          goToDetailsPage(list[index]);
                        },
                        child: AlbumView(
                          imageUrl: list[index].artworkUrl100,
                          albumName: list[index].name,
                          artistName: list[index].artistName,
                          artistId: list[index].artistId.toString(),
                        ),
                      )
                    : list[index].name.toLowerCase().contains(query.toLowerCase()) || list[index].artistName.toLowerCase().contains(query.toLowerCase())
                        ? GestureDetector(
                            onTap: () {
                              goToDetailsPage(list[index]);
                            },
                            child: AlbumView(
                              imageUrl: list[index].artworkUrl100,
                              albumName: list[index].name,
                              artistName: list[index].artistName,
                              artistId: list[index].artistId.toString(),
                            ),
                          )
                        : Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  void goToDetailsPage(AlbumDetails details) {
    Navigator.of(context).push(
      new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return AlbumDetailsScreen(
            details: details,
          );
        },
      ),
    );
  }

  Future<List<AlbumDetails>> getAlbumsFromAPI() async {
    List<AlbumDetails> list = List<AlbumDetails>();
    var response = await http.get('https://rss.itunes.apple.com/api/v1/in/apple-music/new-releases/all/100/non-explicit.json');
    if (response.statusCode == 200) {
      final getMusicListData = getMusicListDataFromJson(response.body);
      list = getMusicListData.feed.albumList;
    }
    return list;
  }
}
