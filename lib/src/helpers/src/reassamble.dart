import 'package:flutter/material.dart';

class ReassembleListener extends StatefulWidget {
  const ReassembleListener(
      {super.key, required this.onReassemble, required this.child});

  final VoidCallback onReassemble;
  final Widget child;

  @override
  _ReassembleListenerState createState() => _ReassembleListenerState();
}

class _ReassembleListenerState extends State<ReassembleListener> {
  @override
  void reassemble() {
    super.reassemble();
    widget.onReassemble();
    }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}