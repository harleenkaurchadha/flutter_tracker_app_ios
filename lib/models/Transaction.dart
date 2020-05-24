import 'package:flutter/foundation.dart';

class Transaction{        //simple class since we don't want it to be a widget to be rendered
final String id;
final String title;
final double amount;
final DateTime date;

Transaction({
  @required this.id, @required this.title, @required this.amount, @required this.date,
});
}