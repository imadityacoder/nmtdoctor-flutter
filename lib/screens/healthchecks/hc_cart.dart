import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nmt_doctor_app/providers/cart_provider.dart';
import 'package:nmt_doctor_app/providers/order_provider.dart';
import 'package:nmt_doctor_app/routes/navbar.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';
import 'package:nmt_doctor_app/widgets/nmtd_snackbar.dart';
import 'package:provider/provider.dart';

class HcCartContent extends StatelessWidget {
  const HcCartContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: nmtdAppbar(
        title: const Text('My Checkups'),
      ),
      bottomNavigationBar: const NmtdNavbar(),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Icon(
                    Icons.add_shopping_cart,
                    size: 100,
                    color: Colors.black12,
                  ),
                ),
                const Text('Nothing is added in cart'),
                TextButton(
                  child: const Text('Go to checkups and add checkups now.'),
                  onPressed: () => context.push('/health-checks'),
                ),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
                child: Text(
                  '  ${cart.items.length} checkup(s)',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black45,
                  ),
                ),
              ),
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
                          "Removed: '${item.title}' from cart",
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
                  icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  label: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16),
                  ),
                  iconAlignment: IconAlignment.end,
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight *
                      0.9, // Limits max height to 90% of screen
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My package',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const Divider(thickness: 1),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          final item = cart.items[index];
                          return ListTile(
                            title: Text(
                              item.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '₹${item.preprice}',
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '₹${item.price}',
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(thickness: 2),
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
                              '₹${cart.pretotal.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '₹${cart.total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 19,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _placeOrder(context, cart);
                        },
                        icon: const Icon(Icons.arrow_forward,
                            color: Colors.white),
                        label: const Text(
                          "Proceed to Booking",
                          style: TextStyle(fontSize: 16),
                        ),
                        iconAlignment: IconAlignment.end,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _placeOrder(BuildContext context, CartProvider cart) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    orderProvider.setTestPackage(
      title: "Custom Package",
      totalPrice: cart.total.toString(),
      items: cart.items
          .map((item) => {
                "title": item.title,
                "price": item.price,
              })
          .toList(),
    );

    cart.clearCart(); // Clear cart after placing the order

    context.pop(); // Navigate to orders page
    context.push('/booking'); // Navigate to orders page
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
          leading: const CircleAvatar(
            maxRadius: 18,
            minRadius: 16,
            child: Icon(Icons.check),
          ),
          title: Text(item.title),
          trailing: InkWell(
            onTap: onRemove,
            child: Icon(
              Icons.delete_outline_outlined,
              color: Colors.red.shade600,
            ),
          ),
        ),
      ),
    );
  }
}
