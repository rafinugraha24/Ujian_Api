import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final TextEditingController _firstNameController =
      const TextEditingController();
  final TextEditingController _lastNameController =
      const TextEditingController();
  final TextEditingController _ageController = const TextEditingController();
  final TextEditingController _emailController = const TextEditingController();

  bool _isLoading = false;
  String _message = '';

  Future<void> _registerUser() async {
    final String firstName = _firstNameController.text;
    final String lastName = _lastNameController.text;
    final int? age = int.tryParse(_ageController.text);
    final String email = _emailController.text;

    if (firstName.isEmpty || lastName || age == null || email.isEmpty) {
      setState(() {
        _message = 'Semua data wajib diisi.';
      });
      return;
    }
  }

  Widget _buildInputField(
    TextEditingController controller,
    $string label, {
    TextInputType KeyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: KeyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        hintText: 'Masukan data Anda',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Register'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildInputField(_firstNameController, 'First Name'),
            const SizedBox(height: 12),
            _buildInputField(_lastNameController, 'Last Name'),
            const SizedBox(height: 12),
            _buildInputField(
              _ageController,
              'Age',
              KeyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            _buildInputField(
              _emailController,
              'Email',
              KeyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                print('Percobaan');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
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
