import 'dart:convert';
import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sertifikasi_jmp/login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  bool isAdmin = false;

  register(BuildContext context) async {
    String url = 'http://192.168.18.32/sertifikasi_jmp2/user/register.php';
    var response = await http.post(Uri.parse(url), body: {
      'username': controllerUsername.text,
      'password': controllerPassword.text,
      'is_admin': isAdmin ? '1' : '0',
    });
    Map responseBody = await jsonDecode(response.body);
    if (responseBody['success']) {
      DInfo.toastSuccess('Registration Success');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } else {
      DInfo.toastError('Registration Failed');
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
            Icon(
              Icons.person_add_alt_1,
              size: 80.0,
              color: Colors.pink.shade200,
            ),
            SizedBox(height: 20.0),
            Text(
              'Create Account',
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
                fillColor: Colors.brown.shade50,
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
                fillColor: Colors.brown.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Checkbox(
                  value: isAdmin,
                  onChanged: (value) {
                    setState(() {
                      isAdmin = value!;
                    });
                  },
                  activeColor: Colors.pink.shade200,
                ),
                Text(
                  'Register as Admin',
                  style: TextStyle(color: Colors.pink.shade200),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => register(context),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  backgroundColor: Colors.pink.shade200,
                ),
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
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
                  'Back to Login',
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
