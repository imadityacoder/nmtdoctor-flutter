import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/providers/cart_provider.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';
import 'package:provider/provider.dart';

class CartContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext innerContext) {
        final cart = Provider.of<CartProvider>(innerContext);
        return Scaffold(
          appBar: nmtdAppbar(),
          body: cart.items.isEmpty
              ? Center(child: Text('Your cart is empty.'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          final item = cart.items[index];
                          return ListTile(
                            title: Text(item.title),
                            subtitle:
                                Text('₹${item.price}'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.redAccent,
                              onPressed: () {
                                cart.removeItem(index);
                                ScaffoldMessenger.of(innerContext).showSnackBar(
                                  SnackBar(
                                    content: Text('${item.title} removed'),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    // Cart Summary and Clear Button
                    Container(
                      padding: EdgeInsets.all(16.0),
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '₹\$',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            onPressed: () {
                              cart.clearCart();
                              ScaffoldMessenger.of(innerContext).showSnackBar(
                                SnackBar(content: Text('Cart Cleared!')),
                              );
                            },
                            child: Text(
                              'Clear Cart',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }}

