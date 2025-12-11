import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final TextEditingController _firstNameController = const TextEditingController();
  final TextEditingController _lastNameController = const TextEditingController();
  final TextEditingController _ageController = const TextEditingController();
  final TextEditingController _emailController = const TextEditingController();

  bool _isLoading = false;
  String _message = '';

  Future<void> _registerUser() async {
    final String firstName = _firstNameController.text;
    final String lastName = _lastNameController.text;
    final int? age = int.tryParse(_ageController.text);
    final String email = _emailController.text;

    if (firstName.isEmpty || lastName.isEmpty || age == null || email.isEmpty) {
      setState(() {
        _message = 'Semua data wajib diisi.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _message = 'Mendaftar... Mohon tunggu';
    });

    const String url = 'https://dummyjson.com/todos';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },

        body: jsonEncode(<String, dynamic>{
          'first_name': firstName,
          'last_name': lastName,
          'age': age,
          'email': email,
        }),
      );

      if (response.statusCode == 2001 || response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        setState(() {
          _message = 'Pendafratan Berhasil! Server ID: ${responseBody['id']}';
          _firstNameController.clear();
          _lastNameController.clear();
          _ageController.clear();
          _emailController.clear();
        });
      } else {
        setState(() {
          _message = 'Pendaftaran Gagal. Status : ${response.statusCode}.';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Terjadi error jaringan: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


@override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Widget _buildInputField(
    TextEditingController controller, 
    String label, 
    {TextInputType keyboardType = TextInputType.text}
  ) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        hintText: 'Masukkan $label Anda',
      ),
    );
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Register'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          children: <Widget>[
            if (_message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  _message,
                  style: TextStyle(
                    color: _message.contains('Berhasil') ? Colors.green.shade700 : Colors.red.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

            _buildInputField(_firstNameController, 'First Name'),
            const SizedBox(height: 12),
            _buildInputField(_lastNameController, 'Last Name'),
            const SizedBox(height: 12),
            _buildInputField(_ageController, 'Age', keyboardType: TextInputType.number),
            const SizedBox(height: 12),
            _buildInputField(_emailController, 'Email', keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _isLoading ? null : _registerUser, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: _isLoading 
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                  : const Text( 
                      'REGISTER',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}