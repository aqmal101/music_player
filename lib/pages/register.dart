import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/base_page.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      GFToast.showToast(
        'All fields are required.',
        context,
        toastPosition: GFToastPosition.CENTER,
        textStyle: const TextStyle(fontSize: 16, color: Colors.white),
        backgroundColor: GFColors.DANGER,
        toastDuration: 2,
      );
      return;
    }

    if (password != confirmPassword) {
      GFToast.showToast(
        'Passwords do not match.',
        context,
        toastPosition: GFToastPosition.CENTER,
        textStyle: const TextStyle(fontSize: 16, color: Colors.white),
        backgroundColor: GFColors.DANGER,
        toastDuration: 2,
      );
      return;
    }

    try {
      await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        data: {'username': username},
      );
    } on AuthException catch (error) {
      // Catch any errors with signing up
      GFToast.showToast(
        error.message,
        context,
        toastPosition: GFToastPosition.CENTER,
        textStyle: const TextStyle(fontSize: 16, color: Colors.white),
        backgroundColor: GFColors.DANGER,
        toastDuration: 2,
      );
    } on Exception catch (error) {
      // Catch any other errors
      GFToast.showToast(
        error.toString(),
        context,
        toastPosition: GFToastPosition.CENTER,
        textStyle: const TextStyle(fontSize: 16, color: Colors.white),
        backgroundColor: GFColors.DANGER,
        toastDuration: 2,
      );
    } finally {
      GFToast.showToast(
        'Sign up successful! Please verify your email.',
        context,
        toastPosition: GFToastPosition.CENTER,
        textStyle: const TextStyle(fontSize: 16, color: Colors.white),
        backgroundColor: GFColors.SUCCESS,
        toastDuration: 2,
      );
      // Set loading state to false
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }

    // if (password != confirmPassword) {
    //   GFToast.showToast(
    //     'Passwords do not match.',
    //     context,
    //     toastPosition: GFToastPosition.CENTER,
    //     textStyle: const TextStyle(fontSize: 16, color: Colors.white),
    //     backgroundColor: GFColors.DANGER,
    //     toastDuration: 2,
    //   );
    //   return;
    // }

    // final response = await supabase.auth.signUp(
    //   email: email,
    //   password: password,
    // );

    // if (response.error != null) {
    //   GFToast.showToast(
    //     response.error!.message,
    //     context,
    //     toastPosition: GFToastPosition.CENTER,
    //     textStyle: const TextStyle(fontSize: 16, color: Colors.white),
    //     backgroundColor: GFColors.DANGER,
    //     toastDuration: 2,
    //   );
    // } else {
    //   GFToast.showToast(
    //     'Sign up successful! Please verify your email.',
    //     context,
    //     toastPosition: GFToastPosition.CENTER,
    //     textStyle: const TextStyle(fontSize: 16, color: Colors.white),
    //     backgroundColor: GFColors.SUCCESS,
    //     toastDuration: 2,
    //   );
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => const LoginPage()),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'SIGN UP',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Create your account',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _usernameController,
              label: 'Username',
              icon: Icons.account_box,
            ),
            _buildTextField(
              controller: _emailController,
              label: 'Email',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            _buildTextField(
              controller: _passwordController,
              label: 'Password',
              icon: Icons.lock,
              isPassword: true,
            ),
            _buildTextField(
              controller: _confirmPasswordController,
              label: 'Confirm Password',
              icon: Icons.lock,
              isPassword: true,
            ),
            const SizedBox(height: 20),
            GFButton(
              fullWidthButton: true,
              color: Colors.orange,
              shape: GFButtonShape.pills,
              onPressed: _register,
              size: GFSize.LARGE,
              text: "Sign Up",
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.center,
              child: Text(
                'OR',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Enter your $label',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22.0),
          ),
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
