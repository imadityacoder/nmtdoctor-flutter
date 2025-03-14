import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:nmt_doctor_app/providers/auth_provider.dart';
import 'package:nmt_doctor_app/widgets/nmtd_snackbar.dart';

class ForgotPasswordContent extends StatefulWidget {
  const ForgotPasswordContent({super.key});

  @override
  _ForgotPasswordContentState createState() => _ForgotPasswordContentState();
}

class _ForgotPasswordContentState extends State<ForgotPasswordContent> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _emailError;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_emailController.text.isEmpty) {
      NmtdSnackbar.show(
        context,
        'Please enter your Email Correctly!',
        type: NoticeType.warning,
      );
    }
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<MyAuthProvider>(context, listen: false);

      setState(() => _isLoading = true);

      try {
        await authProvider.sendPasswordResetEmail(_emailController.text.trim());
        NmtdSnackbar.show(
          context,
          'Password reset email sent! Check your inbox',
          type: NoticeType.success,
        );
        Future.delayed(const Duration(seconds: 2), () => context.pop());
      } catch (e) {
        return;
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  void _validateEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        _emailError = "Please enter your email";
      });
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      setState(() {
        _emailError = "Please enter a valid email address";
      });
    } else {
      setState(() {
        _emailError = null;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue.shade300,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 90,
              ),
              const Text(
                "Reset Password.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              BottomSheet(
                  backgroundColor: Colors.white70,
                  onClosing: () {},
                  builder: (context) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 40),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color: Colors.black45,
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                    ),
                                    focusedErrorBorder:
                                        const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color: Colors.red.shade800,
                                        width: 2,
                                      ),
                                    ),
                                    hintText:
                                        'Enter your current email address',
                                    errorText: _emailError,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: _validateEmail,
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton.icon(
                                  onPressed: _isLoading ? null : _submit,
                                  style: ButtonStyle(
                                    minimumSize: WidgetStateProperty.all(
                                      const Size(double.infinity, 50),
                                    ),
                                    backgroundColor:
                                        WidgetStateProperty.all(Colors.black),
                                    elevation: WidgetStateProperty.all(3),
                                  ),
                                  label: _isLoading
                                      ? const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(
                                            color: Colors.white70,
                                          ),
                                        )
                                      : const Text(
                                          'Send',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontFamily: 'Rubik',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                  icon: Transform.rotate(
                                    angle: -120,
                                    child: const Icon(
                                      Icons.send,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 320,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
