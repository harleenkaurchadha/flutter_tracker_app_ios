import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import 'package:flutter/material.dart';
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
        ),
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
      Transaction(
        id: 't1',
        title: 'New Shoes',
        amount: 69.99,
        date: DateTime.now(),
      ),
      Transaction(
        id:'t2',
        title: 'Weekly Groceries',
        amount: 16.53,
        date: DateTime.now(),
      ),
    ];

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
