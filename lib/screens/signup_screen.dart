import 'package:flutter/material.dart';
import 'success_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  bool _obscurePassword = true;
  bool _submitting = false;
  DateTime? _birthDate;

  final List<String> _tips = [
    'Local Demo Tip: Use a password with at least 8 characters.',
    'Local Demo Tip: Dont use the same password on other websites.',
    'Local Demo Tip: Add at least one number or symbol.',
  ];

  bool _isLoadingTip = false;
  bool _showError = false;
  String _currentTip = '';

  Future<void> _getTip() async {
    setState(() {
      _isLoadingTip = true;
      _showError = false;
      _currentTip = '';
    });

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() {
      _isLoadingTip = false;
      _currentTip = _tips[0];
    });
  }

  Future<void> _simulateError() async {
    setState(() {
      _isLoadingTip = true;
      _showError = false;
      _currentTip = '';
    });

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() {
      _isLoadingTip = false;
      _showError = true;
    });
  }

  Future<void> _selectBirthDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2008),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _birthDate = picked;
        _dateController.text =
            '${picked.month}/${picked.day}/${picked.year}';
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _submitting = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => SuccessScreen(
          userName: _nameController.text.trim(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Haunted Signup Mansion'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Create Your Haunted Guest Pass',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }

                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }

                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _dateController,
                readOnly: true,
                onTap: _selectBirthDate,
                decoration: const InputDecoration(
                  labelText: 'Birth Date',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (_birthDate == null) {
                    return 'Please select your birth date';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _submitting ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                ),
                child: _submitting
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18),
                      ),
              ),

              const SizedBox(height: 40),
              const Divider(),
              const SizedBox(height: 10),

              const Text(
                'Local Demo Signup Coach',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Preset demo content only. No live AI model is used.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _isLoadingTip ? null : _getTip,
                child: const Text('Get Signup Tip'),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: _isLoadingTip ? null : _simulateError,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Test Error State'),
              ),

              const SizedBox(height: 20),

              if (_isLoadingTip)
                const CircularProgressIndicator(),

              if (_currentTip.isNotEmpty)
                Card(
                  color: Colors.purple.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      _currentTip,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),

              if (_showError)
                Column(
                  children: [
                    const Text(
                      'Failed to load local demo tip.',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: _getTip,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}