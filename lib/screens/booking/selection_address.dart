import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/providers/address_provider.dart';
import 'package:nmt_doctor_app/providers/order_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddressSelectionScreen extends StatelessWidget {
  const AddressSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    final orderProvider = Provider.of<OrderProvider>(context);
    final selectedAddress = orderProvider.address;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: OutlinedButton.icon(
                style: const ButtonStyle(
                  minimumSize: WidgetStatePropertyAll(
                    Size(double.infinity, 50),
                  ),
                ),
                onPressed: () => _showAddAddressSheet(context),
                icon: const Icon(Icons.add),
                label: const Text(
                  "Add Address",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
              child: Text(
                'Select Address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Address>>(
                stream: addressProvider.getAddresses(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No addresses found.'));
                  }

                  final addresses = snapshot.data!;

                  return ListView.builder(
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      final address = addresses[index];
                      final isSelected = selectedAddress?.id == address.id;

                      return GestureDetector(
                        onTap: () => orderProvider.setAddress(address),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color:
                                  isSelected ? Colors.blue : Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text(
                              address.title,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(
                              '${address.street}, ${address.city}, ${address.state} - ${address.pincode}',
                            ),
                            leading: const Icon(
                              Icons.location_on,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
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

    _showAddressBottomSheet(
      context,
      title: "Add Address*",
      formKey: formKey,
      controllers: [
        titleController,
        streetController,
        cityController,
        stateController,
        pincodeController
      ],
      onSave: () {
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
    );
  }

  void _showAddressBottomSheet(
    BuildContext context, {
    required String title,
    required GlobalKey<FormState> formKey,
    required List<TextEditingController> controllers,
    required VoidCallback onSave,
  }) {
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
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(controllers[0], 'Title (e.g., Home, Office)'),
                  const SizedBox(height: 10),
                  _buildTextField(controllers[1], 'Street'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: _buildTextField(controllers[2], 'City')),
                      const SizedBox(width: 10),
                      Expanded(child: _buildTextField(controllers[3], 'State')),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(controllers[4], 'Pincode',
                      keyboardType: TextInputType.number),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: onSave,
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
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      validator: (value) =>
          value == null || value.isEmpty ? 'Enter $label' : null,
    );
  }
}
