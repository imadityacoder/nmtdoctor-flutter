import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nmt_doctor_app/api/local_data.dart';
import 'package:nmt_doctor_app/providers/cart_provider.dart';
import 'package:nmt_doctor_app/providers/healthcheck_provider.dart';
import 'package:nmt_doctor_app/routes/navbar.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';
import 'package:nmt_doctor_app/widgets/builders.dart';
import 'package:provider/provider.dart';

class HealthChecksContent extends StatelessWidget {
  const HealthChecksContent({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: nmtdAppbar(
        title: const Text(
          'Health Checks',
        ),
        actionWidget: Consumer<CartProvider>(
          builder: (context, cart, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    context.push("/health-checks/cart");
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                  ),
                ),
                if (cart.items.isNotEmpty)
                  Positioned(
                    right: 7,
                    top: 7,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: Colors.redAccent,
                      child: Text(
                        cart.items.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const NmtdNavbar(),
      body: Consumer<SearchProvider>(
        builder: (context, searchProvider, child) {
          final filteredHealthChecks = healthChecks.where((item) {
            final title = item['title']!.toLowerCase();
            return title.contains(searchProvider.query.toLowerCase());
          }).toList();

          return Column(children: [
            Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFF003580),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search health checks...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    suffixIcon: searchController.text.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              searchController.clear();
                              searchProvider.updateQuery('');
                            },
                          ),
                  ),
                  onChanged: (value) {
                    searchProvider.updateQuery(value);
                  },
                  onSubmitted: (value) {
                    searchProvider.updateQuery(value);
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(10.0),
                children: filteredHealthChecks.map(
                  (item) {
                    return buildHealthCheckItem(
                      context: context,
                      title: item['title']!,
                      price: item['price']!,
                      preprice: item['preprice']!,
                    );
                  },
                ).toList(),
              ),
            ),
          ]);
        },
      ),
    );
  }
}
