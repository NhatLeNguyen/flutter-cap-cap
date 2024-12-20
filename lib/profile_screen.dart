import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin cá nhân'),
        backgroundColor: Colors.orange,
        elevation: 0, // Loại bỏ bóng đổ cho appBar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(3), // Viền xung quanh avatar
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.orange, width: 3), // Viền màu cam
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: const NetworkImage(
                      'https://scontent.fsgn2-6.fna.fbcdn.net/v/t1.6435-9/121099827_675223993393745_5284937244256166736_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeH00IHpCDNrBaowNPs98qPmwlPRbAzk-H_CU9FsDOT4fycUVnRRh8Wm2BC5FZFdrf92SXsZthx16AXIF1enPdnC&_nc_ohc=F0Xep9TVh5oQ7kNvgFOC566&_nc_oc=Adi523PSz-DwUIE4Y-tYGE_bbPHq2aeOrZh-eu3ERJu0IeX5fWYekVyJ8yOMzH49fno&_nc_zt=23&_nc_ht=scontent.fsgn2-6.fna&_nc_gid=A-XztUNmTlAQ5xB5ip0s2M-&oh=00_AYC0Jka71YZ3Rf6Zg-mZwYhjTR56buUMgSR4sCgGpDIT9g&oe=678CB8B0'), // Link ảnh đại diện
                  backgroundColor: Colors.grey[200], // Màu nền nếu không có ảnh
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Đàm Thị Huyền Trang',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.cake, 'Tuổi: 20'),
            _buildInfoRow(Icons.school, 'Nghề nghiệp: Sinh viên'),
            _buildInfoRow(Icons.phone, 'Số điện thoại: 0123456789'),
            _buildInfoRow(Icons.room,
                'Nhu cầu: Tìm phòng trọ khu vực Tây Hồ, Tài chính dưới 5 triệu'),
            const SizedBox(height: 16),
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: const ListTile(
                leading:
                    Icon(Icons.check_circle, color: Colors.green, size: 30),
                title: Text(
                  'Tài khoản đã xác minh',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm giúp xây dựng các dòng thông tin
  Widget _buildInfoRow(IconData icon, String info) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(
          info,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
