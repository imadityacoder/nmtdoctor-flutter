import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/providers/cart_provider.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';
import 'package:nmt_doctor_app/widgets/nmtd_snackbar.dart';
import 'package:provider/provider.dart';

class CartContent extends StatelessWidget {
  const CartContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: nmtdAppbar(
        title: const Text(
          'My Checkups list',
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return CartItemTile(
                      item: item,
                      onRemove: () {
                        cart.removeItemByTitle(item.title);
                        NmtdSnackbar.show(
                          context,
                          "Removed : '${item.title}' from cart",
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () => _showTotalSection(context, cart),
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  label: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  void _showTotalSection(BuildContext context, CartProvider cart) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '₹${cart.total.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade500,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '₹${cart.total.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  label: const Text(
                    "Proceed to Payment",
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRemove;

  const CartItemTile({
    required this.item,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        elevation: 3,
        child: ListTile(
          title: Text(item.title),
          subtitle: Text(
            '₹${item.price}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.red.shade500,
            ),
          ),
          trailing: Text(
            '₹${item.price}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue.shade800,
            ),
          ),
        ),
      ),
    );
  }
}
