import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

class register extends StatelessWidget {
  const register({super.key});

  final TextEditingController _firstNameController =
      const TextEditingController();

  Widget _buildInputField(
    TextEditingController controller,
    $string label, {
    TextInputType KeyboardType = TextInputType.text,
  }) {
    return TextField(controller: controller,
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
          children: [
            _buildInputField(_firstNameController, 'First Name'),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
