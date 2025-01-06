import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/providers/cart_provider.dart';
import 'package:nmt_doctor_app/widgets/nmtd_snackbar.dart';
import 'package:provider/provider.dart';

Widget buildSection1Item({
  required IconData icon,
  required String title,
  required String subtitle,
  required Color backgroundColor,
  VoidCallback? onTap,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            backgroundColor: backgroundColor,
            child: Icon(icon, color: Colors.white),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            subtitle,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    ),
  );
}

Widget buildSection2Item({
  required String title,
  required IconData icon,
  required String preprice,
  required String price,
  VoidCallback? onTap,
  Color titleColor = Colors.black,
  Color descColor = Colors.grey,
  Color priceColor = Colors.green,
  Color prepriceColor = Colors.red,
  double iconSize = 50,
  double elevation = 3,
  double titleFontSize = 16,
  double descFontSize = 13,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, top: 6.0),
    child: Card(
      elevation: 3,
      child: SizedBox(
        width: 220,
        height: 140, // Increased height to accommodate button
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              onTap: onTap,
              leading: Icon(
                icon,
                size: iconSize,
                color: const Color.fromARGB(216, 255, 17, 0),
              ),
              title: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: titleFontSize,
                  color: titleColor,
                ),
                overflow: TextOverflow.clip,
              ),
              subtitle: Row(
                children: [
                  Text(
                    "₹$preprice",
                    style: TextStyle(
                      color: prepriceColor,
                      decoration: TextDecoration.lineThrough,
                      fontSize: descFontSize,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "₹$price",
                    style: TextStyle(
                      color: priceColor,
                      fontWeight: FontWeight.bold,
                      fontSize: descFontSize,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Button action
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(70, 35),
                ),
                child: const Text("Book Now"),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildHealthCheckItem({
  required context,
  required String title,
  required String preprice,
  required String price,
}) {
  return Consumer<CartProvider>(builder: (context, cart, child) {
    bool isInCart = cart.items.any((item) => item.title == title);
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.clip,
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '₹$preprice',
              style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.red,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '₹$price',
              style: const TextStyle(color: Colors.green),
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            if (isInCart) {
              cart.removeItemByTitle(title);
              NmtdSnackbar.show(
                context,
                "Removed : '$title' to cart",
              ); // Remove if already in cart
            } else {
              cart.addItem(CartItem(title: title, price: price)); // Add to cart
              NmtdSnackbar.show(
                context,
                "Added : '$title' to cart",
              );
            }
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(isInCart
                ? const Color.fromARGB(102, 50, 190, 255)
                : const Color.fromARGB(255, 50, 190, 255)),
          ),
          child: Text(
            isInCart ? 'Added' : 'Add',
          ),
        ),
      ),
    );
  });
}
