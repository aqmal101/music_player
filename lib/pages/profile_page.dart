import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:getwidget/getwidget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userID = '';
  String userName = '';
  bool isLoggedIn = false;
  bool isLoading = false;
  late StreamSubscription<AuthState> _authStateChangesSubscription;

  @override
  void initState() {
    super.initState();
    _authStateChangesSubscription =
        Supabase.instance.client.auth.onAuthStateChange.listen((state) {
      if (state.event == AuthChangeEvent.signedIn) {
        final userData = state.session?.user;
        setState(() {
          isLoggedIn = true;
          userID = userData?.id ?? '';
          userName = userData?.userMetadata?['username'] ?? 'Guest';
        });
      } else if (state.event == AuthChangeEvent.signedOut) {
        setState(() {
          isLoggedIn = false;
          userID = '';
          userName = '';
        });
        // Navigate to MyApp on logout
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MyApp()),
          (route) => false,
        );
      }
    });
  }

  @override
  void dispose() {
    _authStateChangesSubscription.cancel();
    super.dispose();
  }

  Future<void> _logout() async {
    setState(() {
      isLoading = true;
    });
    try {
      // Show a success message before performing logout
      GFToast.showToast(
        'Logging out, please wait...',
        context,
        toastPosition: GFToastPosition.BOTTOM,
        textStyle: const TextStyle(fontSize: 16, color: Colors.white),
        backgroundColor: GFColors.DANGER,
        toastDuration: 2, // Display for 2 seconds
      );

      // Add a delay before logging out
      await Future.delayed(const Duration(seconds: 2));

      // Perform logout
      await Supabase.instance.client.auth.signOut();
    } on AuthException catch (error) {
      showErrorSnackBar(context, message: error.message);
    } on Exception catch (error) {
      showErrorSnackBar(context, message: error.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60, right: 20, left: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Colors.orange,
                    width: 2,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      child: GFAvatar(
                        child: Stack(
                          children: [
                            const GFAvatar(
                              backgroundImage: NetworkImage(
                                  'https://raw.githubusercontent.com/aqmal101/background-image/refs/heads/main/%CA%9A%C9%9E.jpeg'),
                              size: GFSize.LARGE,
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: GFBadge(
                                shape: GFBadgeShape.circle,
                                color: GFColors.SUCCESS,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName.isNotEmpty ? userName : 'Guest',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Column(
                              children: const [
                                Text(
                                  '100',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Following'),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Column(
                              children: const [
                                Text(
                                  '200',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Followers'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GFButton(
                fullWidthButton: true,
                shape: GFButtonShape.pills,
                onPressed: isLoading
                    ? null
                    : () {
                        _logout();
                      },
                text: "Logout",
                color: GFColors.DANGER,
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
