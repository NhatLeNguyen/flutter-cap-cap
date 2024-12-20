import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled/post_management.dart';

class PaymentScreen extends StatelessWidget {
  final String postTitle;
  final String price;

  const PaymentScreen(
      {super.key, required this.postTitle, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                '10.000đ',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            Text(
              'Tên bài đăng: $postTitle',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tên người thanh toán: Đàm Thị Huyền Trang',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'Phương thức thanh toán: MoMo',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 10),
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/vi/f/fe/MoMo_Logo.png',
                  height: 25,
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PasswordScreen(postTitle: postTitle, price: price),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Colors.orange,
                ),
                child: const Text('Thanh toán'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordScreen extends StatefulWidget {
  final String postTitle;
  final String price;

  const PasswordScreen(
      {super.key, required this.postTitle, required this.price});

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _submitPassword() {
    if (_passwordController.text == '123456') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              OTPScreen(postTitle: widget.postTitle, price: widget.price),
        ),
      );
    } else {
      // Show error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhập mật khẩu'),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(_focusNode);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '10.000đ',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Nhập mật khẩu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return _buildPasswordDot(index);
                }),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _submitPassword,
                child: const Text('Tiếp tục'),
              ),
              TextField(
                controller: _passwordController,
                focusNode: _focusNode,
                keyboardType: TextInputType.number,
                maxLength: 6,
                obscureText: true,
                cursorColor: Colors.transparent,
                showCursor: false,
                style: const TextStyle(color: Colors.transparent),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordDot(int index) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        _passwordController.text.length > index
            ? _passwordController.text[index]
            : '•',
        style: const TextStyle(fontSize: 24),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

class OTPScreen extends StatefulWidget {
  final String postTitle;
  final String price;

  const OTPScreen({super.key, required this.postTitle, required this.price});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();
  late Timer _timer;
  int _remainingTime = 30;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer.cancel();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const PostManagementScreen()),
            (route) => false,
          );
        }
      });
    });
  }

  void _submitOTP() {
    if (_otpController.text == '123456') {
      _timer.cancel();
      // Update post status to 'Paid but Unapproved'
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Thanh toán thành công'),
          content:
              const Text('Bài đăng của bạn đã được thanh toán thành công.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PostManagementScreen()),
                  (route) => false,
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Show error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Lỗi'),
          content: const Text('Mã OTP không chính xác.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhập mã OTP'),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Nhập mã OTP',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '******',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Thời gian còn lại: $_remainingTime giây',
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _submitOTP,
              child: const Text('Xác nhận'),
            ),
          ],
        ),
      ),
    );
  }
}
