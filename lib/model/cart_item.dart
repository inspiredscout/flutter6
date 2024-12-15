import 'package:practice_6/model/collector.dart';
class CartItem {
  final Collector collector;
  int quantity;

  CartItem({required this.collector, this.quantity = 1});
}
