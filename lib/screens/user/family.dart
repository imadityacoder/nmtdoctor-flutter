import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:nmt_doctor_app/providers/family_provider.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';
import 'package:nmt_doctor_app/widgets/nmtd_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

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

  final List<String> _genders = ['Male', 'Female', "Other"];
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

  Future<void> _newSubmitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(
      () => _isLoading = true,
    );

    final member = FamilyMember(
      id: const Uuid().v4(),
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
    return Scaffold(
      appBar: nmtdAppbar(title: const Text("Family Members")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer<FamilyMemberProvider>(
                builder: (context, familyProvider, _) {
                  return StreamBuilder<List<FamilyMember>>(
                    stream: familyProvider.getFamilyMembers(),
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
                                    _showEditMemberSheet(context, member);
                                  } else if (value == 'delete') {
                                    bool confirmDelete =
                                        await _confirmDeleteDialog(context);
                                    if (confirmDelete) {
                                      familyProvider
                                          .deleteFamilyMember(member.id);
                                    }
                                  }
                                },
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
              style: const ButtonStyle(
                minimumSize: WidgetStatePropertyAll(
                  Size(double.infinity, 50),
                ),
              ),
              onPressed: _showNewMemberSheet,
              child: const Text(
                "Add Family Member",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _confirmDeleteDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Confirm Delete"),
            content: const Text("Are you sure you want to delete this member?"),
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

  void _showNewMemberSheet() {
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
                  style: const ButtonStyle(
                    minimumSize: WidgetStatePropertyAll(
                      Size(double.infinity, 50),
                    ),
                  ),
                  onPressed: _isLoading ? null : _newSubmitForm,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Submit',
                          style: TextStyle(fontSize: 17),
                        ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditMemberSheet(BuildContext context, FamilyMember member) {
    final TextEditingController nameController =
        TextEditingController(text: member.name);
    final TextEditingController ageController =
        TextEditingController(text: member.age.toString());

    String? selectedGender = member.gender;
    String? selectedRelation = member.relation;

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
                  "Edit Member Details",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Full Name Field
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      labelText: 'Full Name', border: OutlineInputBorder()),
                  validator: _validateFullName,
                ),

                const SizedBox(height: 10),

                // Age & Gender Row
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: ageController,
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
                      child: DropdownButtonFormField<String>(
                        value: selectedGender,
                        decoration: const InputDecoration(
                            labelText: 'Gender', border: OutlineInputBorder()),
                        items: _genders
                            .map((gender) => DropdownMenuItem(
                                value: gender, child: Text(gender)))
                            .toList(),
                        onChanged: (value) => selectedGender = value,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Relation Dropdown
                DropdownButtonFormField<String>(
                  value: selectedRelation,
                  decoration: const InputDecoration(
                      labelText: 'Relation', border: OutlineInputBorder()),
                  items: _relations
                      .map((relation) => DropdownMenuItem(
                          value: relation, child: Text(relation)))
                      .toList(),
                  onChanged: (value) => selectedRelation = value,
                ),

                const SizedBox(height: 20),

                // Submit Button
                ElevatedButton(
                  style: const ButtonStyle(
                    minimumSize:
                        WidgetStatePropertyAll(Size(double.infinity, 50)),
                  ),
                  onPressed: _isLoading
                      ? null
                      : () async {
                          if (!_formKey.currentState!.validate()) return;

                          setState(() => _isLoading = true);

                          try {
                            final updatedMember = FamilyMember(
                              id: member
                                  .id, // FIXED: Use original ID instead of creating a new one
                              name: nameController.text.trim(),
                              age: int.parse(ageController.text.trim()),
                              gender: selectedGender!,
                              relation: selectedRelation!,
                            );

                            await Provider.of<FamilyMemberProvider>(context,
                                    listen: false)
                                .updateFamilyMember(updatedMember);

                            if (mounted) context.pop();
                          } catch (e) {
                            _showErrorSnackbar(
                                "Failed to update member. Please try again.");
                          } finally {
                            if (mounted) setState(() => _isLoading = false);
                          }
                        },
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Save Changes',
                          style: TextStyle(fontSize: 17),
                        ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Show error feedback to the user
  void _showErrorSnackbar(String message) {
    NmtdSnackbar.show(context, message);
  }
}
