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
              )
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
    List<Transaction> get _recentTransactions{
      return _userTransactions.where((tx){
        return tx.date.isAfter(
          DateTime.now().subtract(Duration(days: 7),
          ),
        );
        }).toList();
    }

    void _addNewTransaction(String txTitle, double txAmount){
      final newTx= Transaction(
        title: txTitle,
        amount: txAmount,
        date: DateTime.now(),
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

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('Personal Expenses'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startNewTransaction(context),
            )
          ],
        ),
      resizeToAvoidBottomPadding: false,         //to resolve bottom overflow error
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start ,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
             Chart(_recentTransactions),
             TransactionList(_userTransactions),

        ],),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat ,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _startNewTransaction(context),
        ),
      );

  }
}
