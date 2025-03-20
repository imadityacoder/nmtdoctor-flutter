import 'package:flutter/material.dart';
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
          'Health Checkups',
        ),
      ),
      bottomNavigationBar: const NmtdNavbar(),
      body: Consumer<SearchProvider>(
        builder: (context, searchProvider, child) {
          final searchQuery = searchProvider.query; // Ensure non-null
          final filteredHealthChecks = healthChecks.where((item) {
            final title = (item['title'] ?? '').toLowerCase(); // Handle null
            return title.contains(searchQuery.toLowerCase());
          }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                searchController.clear();
                                searchProvider.updateQuery(''); // Clear query
                              },
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      searchProvider.updateQuery(value);
                    },
                  ),
                ),
              ),
              Consumer<CartProvider>(builder: (context, item, child) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 2),
                  child: Text(
                    "${item.items.length} of 48 selected",
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                );
              }),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(10.0),
                  children: filteredHealthChecks.map(
                    (item) {
                      return buildHealthCheckItem(
                        context: context,
                        cardId: item['cardId'] ?? '', // Handle potential null
                        title: item['title'] ?? 'Unknown',
                        price: item['price'] ?? '0',
                        preprice: item['preprice'] ?? '0',
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
