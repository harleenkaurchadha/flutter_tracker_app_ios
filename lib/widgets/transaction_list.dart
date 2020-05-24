import '../models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget{
  final List<Transaction> transactions;   // incoming list of transactions

  TransactionList(this.transactions);
  @override

  Widget build(BuildContext context){
    return Container(
      height: 340,           // constraint on  ListView height it should take
      child: ListView.builder(
        itemBuilder: (ctx, index) {   //executes on every item in the list to be rendered
          return Card(
            child: Row(
              children:[
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  padding: EdgeInsets.all(10) ,
                  child: Text('\$${transactions[index].amount}',
                    style: TextStyle(
                      color: Colors.purpleAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purpleAccent,
                      width: 3,
                      style: BorderStyle.solid,
                    ),
                  ) ,),
                Column(children: [
                  Text(transactions[index].title,style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,)
                    ,),
                  Text(DateFormat.yMMMd().format(transactions[index].date),     //format and return date in string
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ],
            ),
          );
        },
        itemCount: transactions.length,     //how many items should be build
      ),
    );
  }
}