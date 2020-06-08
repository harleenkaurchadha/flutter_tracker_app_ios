import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptiveFlatButton extends StatelessWidget{
  final Function handler;

  AdaptiveFlatButton(this.handler);

  @override
Widget build(BuildContext context){
    return Platform.isIOS ? CupertinoButton(
      child: Text('Choose Date',
          style: TextStyle(
              fontWeight: FontWeight.bold)
      ),
      onPressed: handler,) : FlatButton(
      child: Text('Choose Date',
          style: TextStyle(
              fontWeight: FontWeight.bold)
      ),
      textColor: Theme.of(context).primaryColor,
      onPressed: handler,
    );
  }
}