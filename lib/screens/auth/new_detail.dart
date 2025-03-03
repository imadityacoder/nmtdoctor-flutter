// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:nmt_doctor_app/widgets/nmtd_snackbar.dart';
// import 'package:provider/provider.dart';
// import 'package:nmt_doctor_app/providers/user_provider.dart';

// // A helper function to show the bottom sheet.
// void showUserDetailForm(BuildContext context) {
//   showModalBottomSheet(
//     elevation: 4,
//     context: context,
//     isScrollControlled: true, // Adjusts height when keyboard appears
//     isDismissible: false, // Prevents dismissing by tapping outside
//     enableDrag: false, // Disables swipe-to-dismiss gesture
//     builder: (BuildContext context) {
//       return Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//         ),
//         child: const UserDetailForm(),
//       );
//     },
//   );
// }

// class UserDetailForm extends StatefulWidget {
//   const UserDetailForm({super.key});

//   @override
//   UserDetailFormState createState() => UserDetailFormState();
// }

// class UserDetailFormState extends State<UserDetailForm> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers for form fields.
//   final TextEditingController _fullNameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   String? _selectedGender;

//   // List of gender options.
//   final List<String> _genders = ['Male', 'Female', 'Other'];

//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _phoneController.dispose();
//     _ageController.dispose();
//     super.dispose();
//   }

//   // Validator functions
//   String? _validateFullName(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your full name';
//     }
//     return null;
//   }

//   String? _validatePhone(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your phone number';
//     } else if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
//       return 'Please enter a valid 10-digit phone number';
//     }
//     return null;
//   }

//   String? _validateAge(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your age';
//     }
//     final age = int.tryParse(value);
//     if (age == null || age < 1 || age > 110) {
//       return 'Please enter a valid age';
//     }
//     return null;
//   }

//   String? _validateGender(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please select your gender';
//     }
//     return null;
//   }

//   Future<void> _submitForm() async {
//     if (!_formKey.currentState!.validate() || _selectedGender == null) {
//       return;
//     }

//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("User not logged in!")),
//       );
//       return;
//     }

//     try {
//       await Provider.of<UserProvider>(context, listen: false).addUser(
//         userId: user.uid,
//         email: user.email ?? '',
//         fullName: _fullNameController.text.trim(),
//         phone: _phoneController.text.trim(),
//         age: int.parse(_ageController.text.trim()),
//         gender: _selectedGender!,
//       );
//       Navigator.pop(context); // Close the modal after submission.
//     } catch (error) {
//       NmtdSnackbar.show(context, error.toString(), type: NoticeType.error);
//       print(error.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Enter Your Details*',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _fullNameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Full Name',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: _validateFullName,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: const InputDecoration(
//                   prefixText: '+91 ',
//                   labelText: 'Phone Number',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.phone,
//                 validator: _validatePhone,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: TextFormField(
//                       controller: _ageController,
//                       decoration: const InputDecoration(
//                         labelText: 'Age',
//                         border: OutlineInputBorder(),
//                       ),
//                       keyboardType: TextInputType.number,
//                       validator: _validateAge,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     flex: 1,
//                     child: DropdownButtonFormField<String>(
//                       decoration: const InputDecoration(
//                         labelText: 'Gender',
//                         border: OutlineInputBorder(),
//                       ),
//                       value: _selectedGender,
//                       items: _genders.map((gender) {
//                         return DropdownMenuItem(
//                           value: gender,
//                           child: Text(gender),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           _selectedGender = value;
//                         });
//                       },
//                       validator: _validateGender,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               Center(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size(double.infinity, 50),
//                   ),
//                   onPressed: _submitForm,
//                   child: const Text(
//                     'Submit',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/main.dart';
import 'package:nmt_doctor_app/widgets/nmtd_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:nmt_doctor_app/providers/user_provider.dart';

final account = Account(client);

// A helper function to show the bottom sheet.
void showUserDetailForm(BuildContext context) {
  showModalBottomSheet(
    elevation: 4,
    context: context,
    isScrollControlled: true, // Adjusts height when keyboard appears
    isDismissible: false, // Prevents dismissing by tapping outside
    enableDrag: false, // Disables swipe-to-dismiss gesture
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const UserDetailForm(),
      );
    },
  );
}

class UserDetailForm extends StatefulWidget {
  const UserDetailForm({super.key});

  @override
  UserDetailFormState createState() => UserDetailFormState();
}

class UserDetailFormState extends State<UserDetailForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields.
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? _selectedGender;

  // List of gender options.
  final List<String> _genders = ['Male', 'Female', 'Other'];

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate() || _selectedGender == null) {
      return;
    }

    try {
      await Provider.of<UserProvider>(context, listen: false).addUser(
        
        fullName: _fullNameController.text.trim(),
        phone: _phoneController.text.trim(),
        age: int.parse(_ageController.text.trim()),
        gender: _selectedGender!,
      );
      Navigator.pop(context); // Close the modal after submission.
    } catch (error) {
      NmtdSnackbar.show(context, error.toString(), type: NoticeType.error);
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter Your Details*',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  prefixText: '+91 ',
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 16),
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedGender,
                      items: _genders.map((gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: _submitForm,
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
