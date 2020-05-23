import './widgets/user_transactions.dart';
import 'package:flutter/material.dart';


void main()
{
  runApp(MyApp());
}

 class MyApp extends StatelessWidget{
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: MyHomePage(),
      );
    }
    }

  class MyHomePage extends StatelessWidget{


  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('FLUTTER APP'),
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start ,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
             child: Card(
               child: Text('Charts',style: TextStyle(
                   color: Colors.black26,
                   fontWeight: FontWeight.bold,
                   fontSize: 20)),
               elevation: 10,
               color: Colors.blue,
             ),
             width: double.infinity ,
             ),
            UserTransactions(),

        ],),

      );

  }
}
