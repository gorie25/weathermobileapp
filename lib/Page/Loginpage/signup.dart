import 'package:flutter/material.dart';
import 'package:weather_app/models/auth_services.dart ';
import 'package:firebase_auth/firebase_auth.dart';
class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
            const SizedBox(height: 16),
            // Confirm Password Input
            TextField(
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            // Sign Up Button
            ElevatedButton(
              onPressed: () {
                // AuthService().signUp(email: emailController.text, password: passwordController.text);
                // // Handle sign up logic here
                // print('Sign Up pressed');

                try {
                  AuthService().signUp(
                      email: emailController.text,
                      password: passwordController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Sign Up Successful')),
                  );
                  print('Sign Up Successful');
                  Navigator.pop(context); // Navigate back to Sign In
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to sign up: $e')),
                  );
                  print('Failed to sign up: $e');
                }
              },
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 16),
            // Back to Sign In Button
            TextButton(
              onPressed: () {
                // Navigate back to Sign In
                Navigator.pop(context);
              },
              child: const Text(
                'Already have an account? Sign In',
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
