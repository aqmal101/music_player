import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/base_page.dart';
import 'package:flutter_application_1/pages/register.dart';
import 'package:getwidget/getwidget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'Welcome Back',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter your credentials to login',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
            GFButton(
              fullWidthButton: true,
              shape: GFButtonShape.pills,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Login'),
              onPressed: () async {
                if (_emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty) {
                  await _handleLogin(context);
                } else {
                  // _showAlert(context, 'Error', 'Please fill in all fields.');
                  GFToast.showToast(
                    'Please fill in all fields.',
                    context,
                    toastPosition: GFToastPosition.CENTER,
                    textStyle:
                        const TextStyle(fontSize: 16, color: Colors.white),
                    backgroundColor: GFColors.WARNING,
                    toastDuration: 2, // Display for 2 seconds
                  );
                }
              },
              color: Colors.orange,
              size: GFSize.LARGE,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogin(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await _loginWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (response != null && response.user != null) {
        // Login berhasil
        GFToast.showToast(
          'Login sucessfull!',
          context,
          toastPosition: GFToastPosition.CENTER,
          textStyle: const TextStyle(fontSize: 16, color: Colors.white),
          backgroundColor: GFColors.SUCCESS,
          toastDuration: 2, // Display for 2 seconds
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BasePage(),
          ),
        );
      } else {
        // _showAlert(context, 'Error', 'Login failed. Please try again.');
        GFToast.showToast(
          'Login failed, please try again.',
          context,
          toastPosition: GFToastPosition.CENTER,
          textStyle: const TextStyle(fontSize: 16, color: Colors.white),
          backgroundColor: GFColors.WARNING,
          toastDuration: 2, // Display for 2 seconds
        );
      }
    } catch (e) {
      // _showAlert(context, 'Error', 'Unexpected error occurred: $e');
      GFToast.showToast(
        'Unexpected error occurred: $e',
        context,
        toastPosition: GFToastPosition.CENTER,
        textStyle: const TextStyle(fontSize: 16, color: Colors.white),
        backgroundColor: GFColors.WARNING,
        toastDuration: 2, // Display for 2 seconds
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<AuthResponse?> _loginWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException catch (error) {
      // _showAlert(context, 'Error', error.message);
      GFToast.showToast(
        'Error: ${error.message}',
        context,
        toastPosition: GFToastPosition.BOTTOM,
        textStyle: const TextStyle(fontSize: 16, color: Colors.white),
        backgroundColor: GFColors.DANGER,
        toastDuration: 2, // Display for 2 seconds
      );
    } on Exception catch (e) {
      // _showAlert(context, 'Error', e.toString());
      GFToast.showToast(
        'Error: ${e.toString()}',
        context,
        toastPosition: GFToastPosition.BOTTOM,
        textStyle: const TextStyle(fontSize: 16, color: Colors.white),
        backgroundColor: GFColors.DANGER,
        toastDuration: 2, // Display for 2 seconds
      );
    }
    return null;
  }

  // void _showAlert(BuildContext context, String title, String message) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text(title),
  //       content: Text(message),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
