import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nmt_doctor_app/providers/cart_provider.dart';
import 'package:nmt_doctor_app/providers/healthpack_provider.dart';
import 'package:nmt_doctor_app/screens/healthpacks/detail_pack.dart';
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
  required String cardId,
  required String title,
  required String icon,
  required String preprice,
  required String price,
  required String desc,
  required List tests,
  VoidCallback? onTap,
  Color titleColor = Colors.black,
  Color priceColor = Colors.green,
  Color prepriceColor = Colors.red,
  double iconSize = 70,
  double elevation = 3,
  double titleFontSize = 16,
  double prepriceFontSize = 13,
  double priceFontSize = 15,
  required BuildContext context, // Added context to trigger navigation
}) {
  return GestureDetector(
    onTap: () {
      showHealthPackDetails(
        context,
        cardId: cardId,
        title: title,
        preprice: preprice,
        price: price,
        desc: desc,
        tests: tests,
        svgAsset: icon,
      );
    },
    child: Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: 270,
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    icon,
                    height: iconSize,
                    width: iconSize,
                    fit: BoxFit.contain,
                  ),
                  Row(
                    children: [
                      Text(
                        "₹$preprice",
                        style: TextStyle(
                          color: prepriceColor,
                          decoration: TextDecoration.lineThrough,
                          fontSize: prepriceFontSize,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "₹$price",
                        style: TextStyle(
                          color: priceColor,
                          fontWeight: FontWeight.bold,
                          fontSize: priceFontSize,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  SizedBox(
                    width: 120,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: titleFontSize,
                        color: titleColor,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(120, 36),
                    ),
                    onPressed: () {
                      showHealthPackDetails(
                        context,
                        cardId: cardId,
                        title: title,
                        preprice: preprice,
                        price: price,
                        desc: desc,
                        tests: tests,
                        svgAsset: icon,
                      );
                    },
                    child: const Text("View Details"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildHealthCheckItem({
  required context,
  required String cardId,
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
              cart.addItem(CartItem(
                  cardId: cardId,
                  title: title,
                  price: price,
                  preprice: preprice)); // Add to cart
              NmtdSnackbar.show(
                context,
                "Added : '$title' to cart",
              );
            }
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
                isInCart ? const Color(0xFF003580) : const Color(0xFF0077B6)),
          ),
          child: Text(
            isInCart ? 'Remove' : 'Add',
          ),
        ),
      ),
    );
  });
}

Widget buildHealthPackItem({
  required String cardId,
  required String title,
  required String preprice,
  required String price,
  required String desc,
  required List tests,
  required String svgAsset,
  VoidCallback? onTap,
}) {
  return Consumer<HealthpackProvider>(
    builder: (context, provider, child) {
      return GestureDetector(
        onTap: () => showHealthPackDetails(
          context,
          cardId: cardId,
          title: title,
          desc: desc,
          tests: tests,
          preprice: preprice,
          price: price,
          svgAsset: svgAsset,
        ),
        child: Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      svgAsset,
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 15),
                    Container(
                      width: 1,
                      height: 120,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "₹$preprice",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.red,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "₹$price",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ElevatedButton(
                                  onPressed: () => showHealthPackDetails(
                                    context,
                                    cardId: cardId,
                                    title: title,
                                    desc: desc,
                                    tests: tests,
                                    preprice: preprice,
                                    price: price,
                                    svgAsset: svgAsset,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(90, 35),
                                  ),
                                  child: const Text("View Details"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
