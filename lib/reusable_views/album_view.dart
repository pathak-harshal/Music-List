import 'package:flutter/material.dart';

class AlbumView extends StatelessWidget {
  final String imageUrl;
  final String albumName;
  final String artistName;
  final String artistId;

  const AlbumView({
    Key key,
    this.imageUrl,
    this.albumName,
    this.artistName,
    this.artistId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: "hero_$artistId",
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/artist_placeholder.jpeg',
                image: imageUrl,
                imageScale: 1.0,
                width: 100,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      albumName,
                      overflow: TextOverflow.clip,
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Flexible(
                    child: Text(
                      artistName,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
