import '../models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget{
  final List<Transaction> transactions;   // incoming list of transactions
  final Function deleteTx;

  TransactionList(this.transactions,this.deleteTx);

  @override

  Widget build(BuildContext context){
    return Container(
      height: 400,           // constraint on  ListView height it should take
      child: transactions.isEmpty ? Column(children:[
        Text('No Transactions added yet!!',
              // ignore: deprecated_member_use
              style: Theme.of(context).textTheme.title ,
              ),
             SizedBox(
               height: 20,
             ),  // empty box to act as space between elements
             Container(
               height: 200,
               child: Image.asset('assets/images/waiting.png',
                   fit: BoxFit.cover),//fits the image into container height
             ),],
              )   : ListView.builder(
        itemBuilder: (ctx, index) {   //executes on every item in the list to be rendered
          return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5,
              ),
              child: ListTile(
              leading: CircleAvatar(
              radius: 30,
              child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                  child: Text('\$${transactions[index].amount}')
              ),
              ),
            ),
              title: Text(
                     transactions[index].title,
                     // ignore: deprecated_member_use
                     style: Theme.of(context).textTheme.title),
              subtitle: Text(
                  DateFormat.yMMMd().format(transactions[index].date)
              ),
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => deleteTx(transactions[index].id),               //since we can't pass arguments to function directly
              ),
          ),
          );
        },
        itemCount: transactions.length,     //how many items should be build
      ),
    );
  }
}