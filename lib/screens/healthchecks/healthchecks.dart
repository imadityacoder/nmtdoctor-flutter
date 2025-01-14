import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nmtdoctor_app/api/local_data.dart';
import 'package:nmtdoctor_app/providers/cart_provider.dart';
import 'package:nmtdoctor_app/providers/healthcheck_provider.dart';
import 'package:nmtdoctor_app/routes/navbar.dart';
import 'package:nmtdoctor_app/widgets/nmtd_appbar.dart';
import 'package:nmtdoctor_app/widgets/builders.dart';
import 'package:provider/provider.dart';

class HealthChecksContent extends StatelessWidget {
  const HealthChecksContent({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: nmtdAppbar(),
      bottomNavigationBar: const NmtdNavbar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 10.0, right: 10.0, bottom: 0.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white54,
                prefixIcon: const Icon(Icons.search),
                hintText: "Search health checks...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          context.read<SearchProvider>().updateQuery('');
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                // Update the search query using Provider
                context.read<SearchProvider>().updateQuery(value);
              },
              onSubmitted: (value) {
                // Update the search query using Provider
                context.read<SearchProvider>().updateQuery(value);
              },
            ),
          ),
          Expanded(
            child: Consumer<SearchProvider>(
              builder: (context, searchProvider, child) {
                final filteredHealthChecks = healthChecks.where((item) {
                  final title = item['title']!.toLowerCase();
                  return title.contains(searchProvider.query.toLowerCase());
                }).toList();

                return ListView(
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
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue[200],
        onPressed: () {
          context.push("/health-checks/cart");
        },
        child: Consumer<CartProvider>(
          builder: (context, cart, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.shopping_cart),
                if (cart.items.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: Colors.redAccent,
                      child: Text(
                        cart.items.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
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
    );
  }
}
