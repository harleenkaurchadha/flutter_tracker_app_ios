import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget{
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController=TextEditingController();
  final amountController=TextEditingController();

  void submitData(){
      final enteredTitle= titleController.text;
      final enteredAmount= double.parse(amountController.text);
      if(enteredTitle.isEmpty || enteredAmount<=0)
        {
          return;
        }

      widget.addTx(
          enteredTitle,
          enteredAmount);

      Navigator.of(context).pop();               //to close the topmost screen of display
      }

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
            onSubmitted: (_) => submitData(),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: amountController,
            keyboardType: TextInputType.number,                        //number keyboard should be displayed
            onSubmitted: (_) => submitData(),                       //just the syntax
          ),
          FlatButton(child: Text('Add Transaction'),
            textColor: Colors.purpleAccent,
            onPressed: submitData,
          ),
        ],
      ),
    ),
      elevation: 5,);

  }
}