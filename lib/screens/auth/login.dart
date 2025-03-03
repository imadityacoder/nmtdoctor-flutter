import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nmt_doctor_app/providers/auth_provider.dart';
import 'package:nmt_doctor_app/widgets/nmtd_snackbar.dart';
import 'package:provider/provider.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  _LoginContentState createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginButton() async {
    final authProvider = Provider.of<MyAuthProvider>(context, listen: false);

    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      try {
        setState(() => _isLoading = true);
        await authProvider.signInWithEmail(email, password);
        NmtdSnackbar.show(context, 'Login successful!',
            type: NoticeType.success);
        Future.delayed(const Duration(seconds: 1), () => context.go('/home'));
      } catch (loginError) {
        NmtdSnackbar.show(context, loginError.toString(),
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
                  "LogIn.",
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
            initialChildSize: 0.55, // Initial height
            minChildSize: 0.55, // Minimum height
            maxChildSize: 0.65, // Maximum scrollable height
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
                          controller: _passwordController,
                          hintText: 'Enter your password',
                          isPassword: true,
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your password'
                              : null,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => context.push('/forgot-password'),
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildLoginButton(),
                        const SizedBox(height: 20),
                        _buildGoogleLoginButton(),
                        TextButton(
                          onPressed: () => context.go('/signup'),
                          child: const Text(
                            "Don't have an account? Signup",
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              wordSpacing: 1.4,
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
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
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

  Widget _buildLoginButton() {
    return ElevatedButton.icon(
      onPressed: _isLoading ? null : _loginButton,
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
              'Login',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
    );
  }

  Widget _buildGoogleLoginButton() {
    return ElevatedButton.icon(
      onPressed: () async {
        final authProvider =
            Provider.of<MyAuthProvider>(context, listen: false);
        try {
          await authProvider.signInWithGoogle();
          NmtdSnackbar.show(context, 'Login with Google successful!',
              type: NoticeType.success);
          Future.delayed(const Duration(seconds: 1), () => context.go('/home'));
        } catch (e) {
          NmtdSnackbar.show(context, 'Google sign-in failed!',
              type: NoticeType.error);
        }
      },
      style: ElevatedButton.styleFrom(
        elevation: 3,
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.white,
      ),
      icon: SvgPicture.asset('assets/icons/google.svg'),
      label: const Text(
        'Login with Google',
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
