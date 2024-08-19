import 'dart:convert';
import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sertifikasi_jmp/screens/home_screen.dart';
import 'package:sertifikasi_jmp/register_page.dart';
import 'package:sertifikasi_jmp/screens/admin_screen.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  login(BuildContext context) async {
    String url = 'http://192.168.18.32/sertifikasi_jmp2/user/login.php';
    var response = await http.post(Uri.parse(url), body: {
      'username': controllerUsername.text,
      'password': controllerPassword.text,
    });
    Map responseBody = await jsonDecode(response.body);
    if (responseBody['success']) {
      DInfo.toastSuccess('Login Success');

      if (responseBody['is_admin'] == '1') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdminScreen(),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }
    } else {
      DInfo.toastError('Login Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/gambar.png', // Replace the icon with your asset image
              width: 160.0,
              height: 160.0,
            ),
            SizedBox(height: 20.0),
            Text(
              'Bloomite Petisserie!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade200,
              ),
            ),
            SizedBox(height: 40.0),
            TextFormField(
              controller: controllerUsername,
              decoration: InputDecoration(
                hintText: 'Username',
                prefixIcon: Icon(Icons.person_outline),
                filled: true,
                fillColor: Colors.pink.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: controllerPassword,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock_outline),
                filled: true,
                fillColor: Colors.pink.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => login(context),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  backgroundColor: Colors.pink.shade200,
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  side: BorderSide(color: Colors.pink.shade200),
                ),
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 16.0, color: Colors.pink.shade200),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
