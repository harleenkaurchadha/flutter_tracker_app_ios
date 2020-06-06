import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget{
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController=TextEditingController();    // whenever a text field is modified the listener is notified by text editing controller
  final _amountController=TextEditingController();
   DateTime _selectedDate;

  void _submitData(){
     if(_amountController.text.isEmpty){
       return;
     }
      final enteredTitle= _titleController.text;
      final enteredAmount= double.parse(_amountController.text);
      if(enteredTitle.isEmpty || enteredAmount<=0 || _selectedDate==null )
        {
          return;
        }

      widget.addTx(
          enteredTitle,
          enteredAmount,
          _selectedDate);

      Navigator.of(context).pop();               //to close the topmost screen of display
      }

     void _presentDatePicker()
     {
       showDatePicker(
           context: context,
           initialDate: DateTime.now(),
           firstDate: DateTime(2019),
           lastDate: DateTime.now()
       ).then((pickedDate){                         //informs us when user picked a date and waits for user input
         if(pickedDate== null)
           {
             return;
           }
         setState((){
           _selectedDate= pickedDate;
         });
       });
     }

  @override

  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Card(child: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children:[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,                                     //controller listens and saves the user input
              onSubmitted: (_) => _submitData(),
              ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,                        //number keyboard should be displayed
              onSubmitted: (_) => _submitData(),                       //just the syntax
            ),
            Container(
              height: 70,
              child: Row(children: [
               Expanded(
                child: Text((_selectedDate== null) ? 'No Date Chosen!' : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}'),
               ),
              FlatButton(
                child:
                Text('Choose Date',
                style: TextStyle(
                fontWeight: FontWeight.bold)
                ),
                textColor: Theme.of(context).primaryColor,
                onPressed: _presentDatePicker,
              ),
            ],),
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _submitData,
            ),
          ],
        ),
      ),
        elevation: 5,),
    );

  }
}