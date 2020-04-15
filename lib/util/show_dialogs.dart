//core import
import 'package:flutter/material.dart';

class ShowDialogs {

  static Widget showLoader(String message) {
    return Dialog(
      
      child: Container(
      
        padding: EdgeInsets.all(20.0),
        
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            new CircularProgressIndicator(),
            new Container(
              margin: EdgeInsets.only(top: 20.0),
            ),
            new Text(
              message,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
