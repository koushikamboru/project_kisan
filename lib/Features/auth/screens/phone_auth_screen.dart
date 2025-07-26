import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String _verificationId = '';
  String _status = '';
  bool _codeSent = false;

  void _sendCode() async {
    if (_phoneController.text == '9999999999') {
      setState(() {
        _codeSent = true;
        _status = 'Test code sent. Enter OTP 123456.';
      });
      return;
    }
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${_phoneController.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        setState(() => _status = 'Phone number automatically verified!');
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() => _status = 'Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
          _codeSent = true;
          _status = 'Code sent. Enter OTP.';
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() => _verificationId = verificationId);
      },
    );
  }

  void _verifyCode() async {
    if (_phoneController.text == '9999999999' && _otpController.text == '123456') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      setState(() => _status = 'Test login successful!');
      Navigator.of(context).pushReplacementNamed('/main'); // Update route as needed
      return;
    }
    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: _otpController.text.trim(),
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      setState(() => _status = 'Phone number verified!');
      Navigator.of(context).pushReplacementNamed('/main'); // Update route as needed
    } catch (e) {
      setState(() => _status = 'Invalid OTP.');
    }
  }

  @override
  Widget build(BuildContext context) {
    double fieldFontSize = 18;
    double labelFontSize = 28;
    double buttonFontSize = 18;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Phone Authentication')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                // Country flag and code
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/flags/in.png', // Add this asset for India flag
                      width: 32,
                      height: 32,
                    ),
                    const SizedBox(width: 8),
                    Text('+91', style: TextStyle(fontSize: fieldFontSize)),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 180,
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          hintText: 'Phone number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 20,
                          ),
                        ),
                        style: TextStyle(fontSize: fieldFontSize),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 220,
                  child: ElevatedButton(
                    onPressed: _sendCode,
                    child: Text(
                      'Send OTP',
                      style: TextStyle(
                        fontSize: buttonFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (_codeSent) ...[
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 180,
                    child: TextField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        hintText: 'Enter OTP',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 20,
                        ),
                      ),
                      style: TextStyle(fontSize: fieldFontSize),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 220,
                    child: ElevatedButton(
                      onPressed: _verifyCode,
                      child: Text(
                        'Verify OTP',
                        style: TextStyle(
                          fontSize: buttonFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                Text(_status, style: TextStyle(fontSize: 16, color: Colors.red)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}