import 'package:flutter/material.dart';
import 'package:weather_app/Page/Homepage/home_page.dart';
import 'package:weather_app/Page/Loginpage/signup.dart';
import'package:weather_app/models/auth_services.dart';  


class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Email Input
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            // Password Input
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            // Login Button
            ElevatedButton(
              onPressed: () {

                    try{
                       AuthService().signIn(email: emailController.text, password: passwordController.text);
                                       print('Login pressed');   Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage
                  ()),
                );
                    } catch (e) {
                      print('Failed to sign in');
                    }                // Handle login logic here

              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 16),
            // Sign Up Button (italic text)
            TextButton(
              onPressed: () {
                // Navigate to Sign Up page
                     Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
                print('Navigate to Sign Up');
              },
              child: const Text(
                'Don\'t have an account? Sign Up',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}