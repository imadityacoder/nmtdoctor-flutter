import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/providers/cart_provider.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';
import 'package:provider/provider.dart';

class CartContent extends StatelessWidget {
  const CartContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext innerContext) {
        final cart = Provider.of<CartProvider>(innerContext);
        return Scaffold(
          appBar: nmtdAppbar(),
          body: cart.items.isEmpty
              ? const Center(child: Text('Your cart is empty.'))
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
                              icon: const Icon(Icons.delete),
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
                      height: 300,
                      padding: const EdgeInsets.all(16.0),
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Row(
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
                                '₹',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            onPressed: () {
                              cart.clearCart();
                              ScaffoldMessenger.of(innerContext).showSnackBar(
                                const SnackBar(content: Text('Cart Cleared!')),
                              );
                            },
                            child: const Text(
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

