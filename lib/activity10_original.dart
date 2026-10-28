import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 🧓 Great-Grandparent
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fun Signup App',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class WelcomeScreen extends StatelessWidget {
  final String name;

  const WelcomeScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Text(
          'Welcome, $name!',
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

    setState(() {
      _isLoadingTip = false;
      _showError = true;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Us Today for the Cash Money!'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Create Your Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
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
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
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

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            WelcomeScreen(name: _nameController.text),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                ),
                child: const Text('Sign Up', style: TextStyle(fontSize: 18)),
              ),

              const SizedBox(height: 40),
              const Divider(),
              const SizedBox(height: 10),

              const Text(
                'Local Demo Signup Coach',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                'Preset demo content only. No live AI model is used.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _getTip,
                child: const Text('Get Signup Tip'),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: _simulateError,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Test Error State'),
              ),

              const SizedBox(height: 20),

              if (_isLoadingTip) const CircularProgressIndicator(),

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