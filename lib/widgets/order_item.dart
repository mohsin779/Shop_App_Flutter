import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import "../provider/orders.dart" as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(children: <Widget>[
        ListTile(
          title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
          subtitle: Text(
            DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
          ),
          trailing: IconButton(
            icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
          ),
        ),
        if (_expanded)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            height: min(widget.order.products.length * 20.0 + 10, 100),
            child: ListView(
              children: widget.order.products
                  .map((prods) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            prods.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${prods.quantity}x \$${prods.price}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ))
                  .toList(),
            ),
          )
      ]),
    );
  }
}
