import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nmt_doctor_app/providers/auth_provider.dart';
import 'package:nmt_doctor_app/widgets/nmtd_snackbar.dart';
import 'package:provider/provider.dart';

class SignUpContent extends StatefulWidget {
  const SignUpContent({super.key});

  @override
  _SignUpContentState createState() => _SignUpContentState();
}

class _SignUpContentState extends State<SignUpContent> {
  final _emailController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _password1Controller.dispose();
    _password2Controller.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    final authProvider = Provider.of<MyAuthProvider>(context, listen: false);

    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      final password = _password1Controller.text.trim();

      try {
        setState(() => _isLoading = true);
        await authProvider.signUpWithEmail(email, password);
        NmtdSnackbar.show(
            context, 'Signup successful! Please check your email to verify.',
            type: NoticeType.success);
        Future.delayed(const Duration(seconds: 1), () => context.go('/home'));
      } catch (signupError) {
        NmtdSnackbar.show(context, signupError.toString(),
            type: NoticeType.error);
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: Stack(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(height: 90),
                Text(
                  "SignUp.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.6,
            maxChildSize: 0.65,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: _emailController,
                          hintText: 'Enter your email address',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email address';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _password1Controller,
                          hintText: 'Enter your new password',
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _password2Controller,
                          hintText: 'Re-enter your password',
                          isPassword: true,
                          validator: (value) {
                            if (value != _password1Controller.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        _buildSignUpButton(),
                        const SizedBox(
                          height: 30,
                          child: Center(child: Text('or')),
                        ),
                        _buildGoogleSignUpButton(),
                        TextButton(
                          onPressed: () => context.go('/login'),
                          child: const Text(
                            "Already have an account? Login",
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: _borderStyle(),
        focusedBorder: _borderStyle(borderColor: Colors.black),
        focusedErrorBorder: _borderStyle(borderColor: Colors.red),
        errorBorder: _borderStyle(borderColor: Colors.red.shade800),
        hintText: hintText,
      ),
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton.icon(
      onPressed: _isLoading ? null : _handleSignUp,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.black,
      ),
      icon: const Icon(Icons.mail, color: Colors.white, size: 28),
      label: _isLoading
          ? const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(color: Colors.white70),
            )
          : const Text(
              'Signup',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
    );
  }

  Widget _buildGoogleSignUpButton() {
    return ElevatedButton.icon(
      onPressed: () async {
        final authProvider =
            Provider.of<MyAuthProvider>(context, listen: false);
        try {
          await authProvider.signInWithGoogle();
          NmtdSnackbar.show(context, 'Signup with Google successful!',
              type: NoticeType.success);
          Future.delayed(const Duration(seconds: 1), () => context.go('/home'));
        } catch (e) {
          NmtdSnackbar.show(context, '$e', type: NoticeType.error);
        }
      },
      style: ElevatedButton.styleFrom(
        elevation: 3,
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.white,
      ),
      icon: SvgPicture.asset('assets/icons/google.svg'),
      label: const Text(
        'Signup with Google',
        style: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  OutlineInputBorder _borderStyle({Color borderColor = Colors.black45}) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: borderColor, width: 2),
    );
  }
}
