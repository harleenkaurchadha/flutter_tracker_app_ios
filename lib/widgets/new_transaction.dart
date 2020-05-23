import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget{
  final Function addTx;
  final titleController=TextEditingController();
  final amountController=TextEditingController();

  NewTransaction(this.addTx);

  @override

  Widget build(BuildContext context){
    return Card(child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children:[
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: titleController,                                     //controller listens and saves the user input
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: amountController,
          ),
          FlatButton(child: Text('Add Transaction'),
            textColor: Colors.purpleAccent,
            onPressed: () {
            addTx(titleController.text,
                  double.parse(amountController.text),
            );  //can't give _addNewTransaction since it is a private function in private class
         },
    ),
        ],
      ),
    ),
      elevation: 5,);

  }
}