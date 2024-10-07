import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prettifier/core/extensions/locale_extension.dart';

class CopyButton extends StatefulWidget {
  const CopyButton({super.key, required this.onCopy});

  final Future<void> Function() onCopy;

  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton> {
  bool _showCopied = false;

  Timer? _timer;

  void _toggleState() {
    _timer?.cancel();

    setState(() {
      _showCopied = true;
    });

    _timer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      timer.cancel();
      setState(() {
        _showCopied = false;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFF90B8F8).withOpacity(0.3),
        foregroundColor: Colors.white70,
      ),
      onPressed: () {
        widget.onCopy().then((_) => _toggleState());
      },
      child: Text(
        _showCopied ? context.locale.copied : context.locale.copy,
      ),
    );
  }
}
