import 'package:flutter/material.dart';
import './transaction_list.dart';
import './new_transaction.dart';
import '../models/Transaction.dart';        // .. since we have to go one level up to the models folder



class UserTransactions extends StatefulWidget{

  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions>{

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

  @override
  Widget build(BuildContext context){
    return Column(children: [
      NewTransaction(_addNewTransaction),
      TransactionList(_userTransactions),    // pass the list of transactions
    ],);
  }
}