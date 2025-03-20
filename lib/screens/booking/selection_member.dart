import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:nmt_doctor_app/providers/family_provider.dart';
import 'package:nmt_doctor_app/providers/order_provider.dart';
import 'package:nmt_doctor_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class MemberSelectionScreen extends StatefulWidget {
  const MemberSelectionScreen({super.key});

  @override
  _MemberSelectionScreenState createState() => _MemberSelectionScreenState();
}

class _MemberSelectionScreenState extends State<MemberSelectionScreen> {
  String? _selectedMemberId;
  Map<String, dynamic>? _selfData;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String? _selectedGender;
  String? _selectedRelation;
  bool _isLoading = false;

  final List<String> _genders = ["Male", "Female", "Other"];
  final List<String> _relations = [
    'Father',
    'Mother',
    'Sibling',
    'Spouse',
    'Child',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _fetchSelfData();
  }

  Future<void> _fetchSelfData() async {
    final userData = Provider.of<UserProvider>(context, listen: false).userData;
    if (userData != null) {
      _selfData = userData;
    } else {
      _selfData = null;
    }
  }

  void _selectMember(String memberId, FamilyMember member) {
    setState(() {
      _selectedMemberId = memberId; // Keep track of selected member
    });
    Provider.of<OrderProvider>(context, listen: false).setMember(member);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_selfData != null)
              Padding(
                padding: const EdgeInsets.all(8),
                child: OutlinedButton.icon(
                  style: const ButtonStyle(
                    minimumSize: WidgetStatePropertyAll(
                      Size(double.infinity, 50),
                    ),
                  ),
                  onPressed: _showNewMemberSheet,
                  icon: const Icon(Icons.add),
                  label: const Text(
                    "Add Family Member",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Select Patient',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _selfData != null
                ? _buildMemberCard(
                    memberId: _selfData?['uid'] ?? 'self',
                    name: _selfData?['fullName'] ?? "",
                    relation: "Self",
                    age: _selfData?['age']?.toString() ?? '',
                    gender: _selfData?['gender'] ?? "",
                    userId: user?.uid ?? "",
                  )
                : const SizedBox(),
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
                          return _buildMemberCard(
                            memberId: member.id,
                            name: member.name,
                            relation: member.relation,
                            age: member.age.toString(),
                            gender: member.gender,
                            userId: member.id,
                          );
                        },
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

  Widget _buildMemberCard({
    required String memberId,
    required String name,
    required String relation,
    required String age,
    required String gender,
    required String userId,
  }) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, _) {
        final isSelected = orderProvider.member?.id == memberId;

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: isSelected ? Colors.blue : Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: Text(
              name,
              style: const TextStyle(fontSize: 17),
            ),
            subtitle: Text("$relation, Age: $age"),
            leading: gender == "Male"
                ? const Icon(Icons.person)
                : const Icon(Icons.person_2),
            onTap: () {
              _selectMember(
                memberId,
                FamilyMember(
                  id: userId,
                  name: name,
                  age: int.tryParse(age) ?? 0,
                  gender: gender,
                  relation: relation,
                ),
              );
            },
          ),
        );
      },
    );
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
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter full name";
                    }
                    if (value.length < 3) {
                      return "Name must be at least 3 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _ageController,
                        decoration: const InputDecoration(
                          labelText: 'Age',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Enter the age";
                          }
                          final int? age = int.tryParse(value);
                          if (age == null || age <= 0 || age > 110) {
                            return "Enter a valid age";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Gender',
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedGender,
                        items: _genders
                            .map((gender) => DropdownMenuItem(
                                value: gender, child: Text(gender)))
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _selectedGender = value),
                        validator: (value) =>
                            value == null ? "Select gender" : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Relation',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedRelation,
                  items: _relations
                      .map((relation) => DropdownMenuItem(
                          value: relation, child: Text(relation)))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _selectedRelation = value),
                  validator: (value) =>
                      value == null ? "Select relation" : null,
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

  Future<void> _newSubmitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
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
}
