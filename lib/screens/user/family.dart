import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:nmt_doctor_app/providers/family_provider.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';
import 'package:provider/provider.dart';

class FamilyMemberForm extends StatefulWidget {
  const FamilyMemberForm({super.key});

  @override
  _FamilyMemberFormState createState() => _FamilyMemberFormState();
}

class _FamilyMemberFormState extends State<FamilyMemberForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? _selectedGender;
  String? _selectedRelation;
  bool _isLoading = false;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _relations = [
    'Father',
    'Mother',
    'Sibling',
    'Spouse',
    'Child',
    'Other'
  ];

  String? _validateFullName(String? value) {
    return (value == null || value.isEmpty)
        ? 'Please enter your full name'
        : null;
  }

  String? _validateAge(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your age';
    final age = int.tryParse(value);
    if (age == null || age < 1 || age > 110) return 'Please enter a valid age';
    return null;
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(
      () => _isLoading = true,
    );

    final member = FamilyMember(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      age: int.parse(_ageController.text.trim()),
      gender: _selectedGender!,
      relation: _selectedRelation!,
    );
    await Provider.of<FamilyMemberProvider>(context, listen: false)
        .addFamilyMember(member);

    setState(() => _isLoading = false);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final familyProvider =
        Provider.of<FamilyMemberProvider>(context, listen: false);

    return Scaffold(
      appBar: nmtdAppbar(title: const Text("Family Members")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer<FamilyMemberProvider>(
                builder: (context, provider, _) {
                  return FutureBuilder<List<FamilyMember>>(
                    future: familyProvider.getFamilyMembers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text("No family members added."));
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final member = snapshot.data![index];
                          return Card(
                            elevation: 3,
                            child: ListTile(
                              title: Text(
                                member.name,
                                style: const TextStyle(fontSize: 17),
                              ),
                              subtitle: Text(
                                  "${member.relation}, Age: ${member.age}"),
                              leading: member.gender == "Male"
                                  ? const Icon(Icons.person)
                                  : const Icon(Icons.person_2),
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
                                      onPressed: () => provider
                                          .deleteFamilyMember(member.id),
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
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _showBottomSheet,
              style: const ButtonStyle(
                  minimumSize:
                      WidgetStatePropertyAll(Size(double.infinity, 30))),
              child: const Text("Add Family Member"),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Enter the person's details*",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      labelText: 'Full Name', border: OutlineInputBorder()),
                  validator: _validateFullName,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _ageController,
                        decoration: const InputDecoration(
                            labelText: 'Age', border: OutlineInputBorder()),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: _validateAge,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                            labelText: 'Gender', border: OutlineInputBorder()),
                        value: _selectedGender,
                        items: _genders
                            .map((gender) => DropdownMenuItem(
                                value: gender, child: Text(gender)))
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _selectedGender = value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                      labelText: 'Relation', border: OutlineInputBorder()),
                  value: _selectedRelation,
                  items: _relations
                      .map((relation) => DropdownMenuItem(
                          value: relation, child: Text(relation)))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _selectedRelation = value),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Submit'),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
