import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/providers/address_provider.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddressForm extends StatelessWidget {
  const AddressForm({super.key});

  @override
  Widget build(BuildContext context) {
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);

    return Scaffold(
      appBar: nmtdAppbar(title: const Text("My Addresses")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Address>>(
              stream: addressProvider.getAddresses(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No addresses found.'));
                }

                final addresses = snapshot.data!;

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    final address = addresses[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(
                          address.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                        subtitle: Text(
                          '${address.street}, ${address.city}, ${address.state} - ${address.pincode}',
                        ),
                        leading: const Icon(
                          Icons.location_on,
                        ),
                        trailing: MenuAnchor(
                          builder: (context, controller, child) {
                            return IconButton(
                              icon: const Icon(Icons.more_vert),
                              onPressed: () => controller.open(),
                            );
                          },
                          menuChildren: [
                            MenuItemButton(
                              child: TextButton.icon(
                                onPressed: () {},
                                label: const Text("Edit"),
                                icon: const Icon(Icons.edit),
                              ),
                            ),
                            MenuItemButton(
                              child: TextButton.icon(
                                onPressed: () =>
                                    addressProvider.deleteAddress(address.id),
                                label: const Text("Delete"),
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: const ButtonStyle(
                minimumSize: WidgetStatePropertyAll(
                  Size(double.infinity, 50),
                ),
              ),
              onPressed: () => _showAddAddressSheet(context),
              child: const Text(
                "Add Address",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddAddressSheet(BuildContext context) {
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    final formKey = GlobalKey<FormState>();

    final TextEditingController titleController = TextEditingController();
    final TextEditingController streetController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController stateController = TextEditingController();
    final TextEditingController pincodeController = TextEditingController();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Add Address*',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton.icon(
                        label: const Text('Use my location'),
                        onPressed: () {},
                        icon: const Icon(Icons.my_location_outlined),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                      titleController, 'Title (e.g., Home, Office)'),
                  const SizedBox(height: 10),
                  _buildTextField(streetController, 'Street'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: _buildTextField(cityController, 'City')),
                      const SizedBox(width: 10),
                      Expanded(
                          child: _buildTextField(stateController, 'State')),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(pincodeController, 'Pincode',
                      keyboardType: TextInputType.number),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: const ButtonStyle(
                      minimumSize: WidgetStatePropertyAll(
                        Size(double.infinity, 50),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final newAddress = Address(
                          id: const Uuid().v4(),
                          title: titleController.text,
                          street: streetController.text,
                          city: cityController.text,
                          state: stateController.text,
                          pincode: pincodeController.text,
                        );

                        addressProvider.addAddress(newAddress);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Save Address',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      decoration:
          InputDecoration(labelText: label, border: const OutlineInputBorder()),
      keyboardType: keyboardType,
      validator: (value) =>
          value == null || value.isEmpty ? 'Enter $label' : null,
    );
  }
}
