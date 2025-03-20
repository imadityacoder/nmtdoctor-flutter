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

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
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
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Text("Edit"),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Text(
                                "Delete",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                          onSelected: (value) async {
                            if (value == 'edit') {
                              _showEditAddressSheet(context, address);
                            } else if (value == 'delete') {
                              bool confirmDelete =
                                  await _confirmDeleteDialog(context);
                              if (confirmDelete) {
                                addressProvider.deleteAddress(address.id);
                              }
                            }
                          },
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
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
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

    _showAddressBottomSheet(
      context,
      title: "Add Address",
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

  void _showEditAddressSheet(BuildContext context, Address address) {
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    final formKey = GlobalKey<FormState>();

    final TextEditingController editTitleController =
        TextEditingController(text: address.title);
    final TextEditingController editStreetController =
        TextEditingController(text: address.street);
    final TextEditingController editCityController =
        TextEditingController(text: address.city);
    final TextEditingController editStateController =
        TextEditingController(text: address.state);
    final TextEditingController editPincodeController =
        TextEditingController(text: address.pincode);

    _showAddressBottomSheet(
      context,
      title: "Edit Address",
      formKey: formKey,
      controllers: [
        editTitleController,
        editStreetController,
        editCityController,
        editStateController,
        editPincodeController
      ],
      onSave: () {
        if (formKey.currentState!.validate()) {
          final updatedAddress = Address(
            id: address.id,
            title: editTitleController.text,
            street: editStreetController.text,
            city: editCityController.text,
            state: editStateController.text,
            pincode: editPincodeController.text,
          );

          addressProvider.updateAddress(address.id, updatedAddress);
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
                      fontSize: 18,
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
                      Expanded(
                          child: _buildTextField(
                        controllers[3],
                        'State',
                      )),
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
      decoration:
          InputDecoration(labelText: label, border: const OutlineInputBorder()),
      keyboardType: keyboardType,
      validator: (value) =>
          value == null || value.isEmpty ? 'Enter $label' : null,
    );
  }

  Future<bool> _confirmDeleteDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Confirm Delete"),
            content:
                const Text("Are you sure you want to delete this address?"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("Delete",
                      style: TextStyle(color: Colors.red))),
            ],
          ),
        ) ??
        false;
  }
}
