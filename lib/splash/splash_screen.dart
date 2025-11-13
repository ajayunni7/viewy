import 'dart:async';

import 'package:flutter/material.dart';
import 'package:viewy_test/core/api_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 5), _navigateToLogin);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _navigateToLogin() {
    _navigateNext();
  }

  void _navigateNext() {
    if (!mounted) return;
    final isAuthenticated = ApiService().isAuthenticated;
    final routeName = isAuthenticated ? '/home' : '/login';
    Navigator.of(context).pushReplacementNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
