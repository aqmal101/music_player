import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/register.dart';
import 'package:getwidget/getwidget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(
            'https://raw.githubusercontent.com/aqmal101/background-image/refs/heads/main/disc-player.jpeg',
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Ready to Immerse Yourself in Music ?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                GFButton(
                  fullWidthButton: true,
                  shape: GFButtonShape.pills,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  text: "Login",
                  color: Colors.orange,
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "or Do you already have an account?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()),
                        );
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
