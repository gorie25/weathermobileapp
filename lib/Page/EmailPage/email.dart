import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class EmailDialog extends StatefulWidget {
  final List<Map<String, dynamic>> forecastData;

  const EmailDialog({Key? key, required this.forecastData}) : super(key: key);

  @override
  _EmailDialogState createState() => _EmailDialogState();
}

class _EmailDialogState extends State<EmailDialog> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> sendWeatherEmail(String toEmail, String weatherInfo) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final serviceId = 'service_tq709si';  // Thay bằng service_id của bạn
    final templateId = 'template_75bv74e';  // Thay bằng template_id của bạn
    final userId = '3LMivM6Z562AI5hsY';  // Thay bằng user_id của bạn

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'origin': 'http://localhost',  // Đảm bảo origin chính xác
        },
        body: jsonEncode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'to_email': toEmail,
            'from_name': 'TruongTien',  // Tên người gửi
            'message': weatherInfo,      // Nội dung dự báo thời tiết
          },
        }),
      );

      if (response.statusCode == 200) {
        print('Email sent successfully');
        Navigator.pop(context); // Close the dialog
      } else {
        print('Failed to send email');
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to send email');
      }
    } catch (error) {
      print('[SEND FEEDBACK MAIL ERROR] $error');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to send email. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter Your Email'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Enter your email',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              String email = _emailController.text;
              String weatherInfo = widget.forecastData.map((data) {
                return DateFormat("MMMMEEEEd").format(DateTime.parse(data['date'].toString())) +
                    ': ' +
                    data['condition'] +
                    ', Min Temp: ' +
                    data['mintempC'].toString() +
                    ', Max Temp: ' +
                    data['maxtempC'].toString();
              }).join('\n');

              sendWeatherEmail(email, weatherInfo);
            },
            child: Text('Send Weather Info'),
          ),
        ],
      ),
    );
  }
}