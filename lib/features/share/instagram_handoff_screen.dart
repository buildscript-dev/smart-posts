import 'dart:async';

import 'package:flutter/material.dart';

/// Simulated OS handoff: Instagram splash ("from Meta"), then back to feed.
class InstagramHandoffScreen extends StatefulWidget {
  const InstagramHandoffScreen({super.key});

  @override
  State<InstagramHandoffScreen> createState() => _InstagramHandoffScreenState();
}

class _InstagramHandoffScreenState extends State<InstagramHandoffScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1800), () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child:
                Image.asset('assets/images/instagram_logo.png', width: 90),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 48,
            child: Column(
              children: [
                const Text('from',
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 2),
                Text('∞ Meta',
                    style: TextStyle(
                        color: Colors.blueGrey.shade700,
                        fontSize: 17,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
