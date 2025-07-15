import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'authentication.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key, required this.user});

  final User? user;

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  User? _user;
  bool _isSigningOut = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  @override
  void initState() {
    _user = widget.user ?? FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return Scaffold(body: Center(child: Text("User tidak ditemukan")));
    }

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(title: Text("User Info"), backgroundColor: Colors.black87),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _user!.photoURL != null
                    ? ClipOval(
                        child: Image.network(
                          _user!.photoURL!,
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      )
                    : CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[700],
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                SizedBox(height: 24),
                Text(
                  _user!.displayName ?? 'Nama tidak tersedia',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  _user!.email ?? 'Email tidak tersedia',
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                ),
                SizedBox(height: 32),
                _isSigningOut
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.redAccent,
                        ),
                      )
                    : ElevatedButton.icon(
                        icon: Icon(Icons.logout),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            _isSigningOut = true;
                          });
                          await Authentication.signOut(context: context);
                          setState(() {
                            _isSigningOut = false;
                          });
                          Navigator.of(
                            context,
                          ).pushReplacement(_routeToSignInScreen());
                        },
                        label: Text(
                          'Sign Out',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
