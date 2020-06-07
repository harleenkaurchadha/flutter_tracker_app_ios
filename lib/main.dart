import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/Transaction.dart';


void main()
{
  runApp(MyApp());
}

 class MyApp extends StatelessWidget{
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Personal Expenses',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.teal,
            fontFamily: 'Quicksand',              //global font
            textTheme: ThemeData.light().textTheme.copyWith(
              // ignore: deprecated_member_use
              title: TextStyle(           //object with name title will apply this theme style
                fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
              ),
              button: TextStyle(
              color: Colors.white,
            ),
            ),
            appBarTheme: AppBarTheme(
              textTheme:ThemeData.light().textTheme.copyWith(  //all text element in appbar receives this theme(make as default)
                // ignore: deprecated_member_use
                title: TextStyle(                            //and copy that with new overwritten values
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
               ),
            )),
        home: MyHomePage(),
      );
    }
    }

  class MyHomePage extends StatefulWidget{

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

  class _MyHomePageState extends State<MyHomePage> {

    final List<Transaction> _userTransactions=[
//      Transaction(
//        id: 't1',
//        title: 'New Shoes',
//        amount: 69.99,
//        date: DateTime.now(),
//      ),
//      Transaction(
//        id:'t2',
//        title: 'Weekly Groceries',
//        amount: 16.53,
//        date: DateTime.now(),
//      ),
    ];
    bool _showChart=false;

    List<Transaction> get _recentTransactions{
      return _userTransactions.where((tx){
        return tx.date.isAfter(
          DateTime.now().subtract(Duration(days: 7),
          ),
        );
        }).toList();
    }

    void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate){
      final newTx= Transaction(
        title: txTitle,
        amount: txAmount,
        date: chosenDate,
        id: DateTime.now().toString(),
      );

      setState((){
        _userTransactions.add(newTx);   // since the userTransactions is final so we can only manipulate the obj and not provide it with value
      });
    }

    void _startNewTransaction(BuildContext ctx){
     showModalBottomSheet(context: ctx, builder: (_) {
       return GestureDetector(
         child: NewTransaction(_addNewTransaction),
         onTap: () {},
         behavior: HitTestBehavior.opaque,
       );
      },
     );
  }

   void _deleteTransaction(String id) {
     setState(() {
       _userTransactions.removeWhere((tx) => tx.id== id);

     });
   }
  @override
  Widget build(BuildContext context){
      final mediaQuery = MediaQuery.of(context);
      final isLandscape= mediaQuery.orientation== Orientation.landscape;
      final PreferredSizeWidget appBar= Platform.isIOS ? CupertinoNavigationBar(
        middle: Text('Personal Expenses',),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children:[
         GestureDetector(                //we need to create button since icon button not there in cupertino
           child: Icon(CupertinoIcons.add),
           onTap: ()=> _startNewTransaction(context),
         ),
        ],
        ),
      ): AppBar(     //since this object now store info about the height of the appBar
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startNewTransaction(context),
          )
        ],
      );
      final txList=  Container(
        height: (mediaQuery.size.height-
            appBar.preferredSize.height-
            mediaQuery.padding.top) * 0.7,
        child: TransactionList(_userTransactions,_deleteTransaction),
      );

      final pageBody= SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start ,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if(isLandscape) Row(                    // if true then row is added otherwise nothing
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart'),
                Switch(
                  value: _showChart,
                  onChanged: (val){
                    setState((){
                      _showChart=val;
                    });
                  },
                ),
              ],
            ),
            if(!isLandscape) Container(
              height: (mediaQuery.size.height-
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) * 0.3,
              child: Chart(_recentTransactions),
            ),
            if(!isLandscape) txList,
            if(isLandscape) _showChart ? Container(
              height: (mediaQuery.size.height-
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) * 0.7,
              child: Chart(_recentTransactions),
            )  :
            txList,

          ],
        ),
      );
    return Platform.isIOS ? CupertinoPageScaffold(
       child: pageBody,
       navigationBar: appBar,
       )  : Scaffold(
        appBar: appBar,
//      resizeToAvoidBottomPadding: false,         //to resolve bottom overflow error
        body: pageBody,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat ,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _startNewTransaction(context),
        ),
      );

  }
}
