import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tiny_rsa_tool/assets/assets.gen.dart';
import 'package:tiny_rsa_tool/encryption_helper.dart';
import 'package:tiny_rsa_tool/widgets/check_box_tile.dart';
import 'package:tiny_rsa_tool/widgets/custom_text_field.dart';
import 'package:tiny_rsa_tool/widgets/footer.dart';
import 'package:tiny_rsa_tool/widgets/responsive_builder.dart';
import 'package:url_strategy/url_strategy.dart';
import "package:universal_html/html.dart" as html;

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiny RSA Tool',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.black),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            minimumSize: MaterialStateProperty.all(
              (const Size(200, 48), const Size(140, 48)).resolve,
            ),
          ),
        ),
      ),
      home: const MyHomePage(title: 'Tiny RSA Tool'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final _encryptionHelper = EncryptionHelper();
  final _payloadController = TextEditingController();
  final _keyController = TextEditingController();
  final _resultController = TextEditingController();
  EncryptionKeyType _encryptionKeyType = EncryptionKeyType.private;
  bool _forEncryption = true;

  void _process() {
    if (_payloadController.text.isEmpty || _keyController.text.isEmpty) {
      return;
    }

    if (_forEncryption) {
      _encrypt();
    } else {
      _decrypt();
    }
  }

  void _encrypt() {
    _resultController.text = _encryptionHelper.encrypt(
      _payloadController.text,
      _keyController.text,
      encryptionKeyType: _encryptionKeyType,
    );
  }

  void _decrypt() {
    _resultController.text = _encryptionHelper.decrypt(
      _payloadController.text,
      _keyController.text,
      encryptionKeyType: _encryptionKeyType,
    );
  }

  @override
  void dispose() {
    _payloadController.dispose();
    _keyController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TinyRsaToolAssets.logo.image(
                  height: (40.0, 32.0).resolve,
                  width: (40.0, 32.0).resolve,
                ),
                SizedBox(width: (8.0, 4.0).resolve),
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFF3E43),
                      ),
                ),
              ],
            ),
            InkWell(
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                html.window.open(
                  'https://tools.luckyebere.com/',
                  "Lucky's Tools",
                );
              },
              child: Text(
                "From Lucky's Tools",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF0BC19E),
                    ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: (20.0, 10.0).resolve),
              Expanded(
                child: ScrollConfiguration(
                  behavior: const MouseDraggableScrollBehavior(),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          CustomCheckBoxTile(
                            checked: _forEncryption,
                            onTap: (value) {
                              setState(() {
                                _forEncryption = true;
                              });
                            },
                            title: 'Encryption',
                          ),
                          SizedBox(width: (16.0, 8.0).resolve),
                          CustomCheckBoxTile(
                            checked: !_forEncryption,
                            onTap: (value) {
                              setState(() {
                                _forEncryption = false;
                              });
                            },
                            title: 'Decryption',
                          ),
                        ],
                      ),
                      SizedBox(height: (20.0, 10.0).resolve),
                      CustomTextField(
                        controller: _payloadController,
                        maxLines: 6,
                        hintText: 'Enter payload',
                      ),
                      SizedBox(height: (20.0, 10.0).resolve),
                      CustomTextField(
                        controller: _keyController,
                        maxLines: 3,
                        hintText: 'Public/private key',
                      ),
                      SizedBox(height: (32.0, 16.0).resolve),
                      Row(
                        children: [
                          CustomCheckBoxTile(
                            checked:
                                _encryptionKeyType == EncryptionKeyType.private,
                            onTap: (value) {
                              if (value) {
                                setState(() {
                                  _encryptionKeyType =
                                      EncryptionKeyType.private;
                                });
                              }
                            },
                            title: 'Private Key',
                          ),
                          SizedBox(width: (16.0, 8.0).resolve),
                          CustomCheckBoxTile(
                            checked:
                                _encryptionKeyType == EncryptionKeyType.public,
                            onTap: (value) {
                              if (value) {
                                setState(() {
                                  _encryptionKeyType = EncryptionKeyType.public;
                                });
                              }
                            },
                            title: 'Public Key',
                          ),
                          SizedBox(width: (24.0, 12.0).resolve),
                          TextButton(
                            onPressed: _process,
                            child: const Text('Process'),
                          ),
                        ],
                      ),
                      SizedBox(height: (32.0, 16.0).resolve),
                      CustomTextField(
                        controller: _resultController,
                        maxLines: 6,
                        hintText: 'Result',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: (20.0, 10.0).resolve),
              const Align(
                alignment: Alignment.centerRight,
                child: Footer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MouseDraggableScrollBehavior extends MaterialScrollBehavior {
  const MouseDraggableScrollBehavior();
  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
