import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tin nhắn'),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://phongvu.vn/cong-nghe/wp-content/uploads/2024/09/Meme-meo-bieu-cam-1024x1024.jpg'), // Ảnh đại diện của bạn bè
            ),
            title: Text('Nguyễn Văn A'),
            subtitle: Text('Tin nhắn gần đây...'),
            onTap: () {
              // Mở chi tiết tin nhắn
            },
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150'), // Ảnh đại diện
            ),
            title: const Text('Nhóm chủ trọ ở Linh Đàm'),
            subtitle: Text('Bạn: Gặp nhau lúc nào?'),
            onTap: () {
              // Mở chi tiết nhóm
            },
          ),
        ],
      ),
    );
  }
}
