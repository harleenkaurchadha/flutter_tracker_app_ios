import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget{
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context){
    return Column(
        children:[
        Container(
          height: 20,           // to fix the height of box since with large value bar shifts upside
       child: FittedBox(                                        // to avoid line break in amount value after flexible widget
       child: Text('\$${spendingAmount.toStringAsFixed(0)}'),     //without decimal places
      ),
        ),
      SizedBox(height: 4,),
      Container(
        height: 60,
        width: 10,
        child: Stack(children:[                      //overlaps widget starting from bottom
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0),
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(10),
            ),
          ),
          FractionallySizedBox(                        //creating a box which is fraction of the outer container
            heightFactor: spendingPctOfTotal,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),),
        ]
        ),
      ),
      SizedBox(height: 4),
      Text(label),
    ]);
  }
}