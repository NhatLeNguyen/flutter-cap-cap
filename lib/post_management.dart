import 'package:flutter/material.dart';
import 'package:untitled/payment-screen.dart';

class PostManagementScreen extends StatefulWidget {
  const PostManagementScreen({super.key});

  @override
  _PostManagementScreenState createState() => _PostManagementScreenState();
}

class _PostManagementScreenState extends State<PostManagementScreen> {
  String filter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý bài đăng'),
        backgroundColor: Colors.orange,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                filter = value;
              });
            },
            itemBuilder: (BuildContext context) {
              return ['All', 'Approved', 'Unpaid', 'Paid but Unapproved']
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ListView(
        children: getFilteredPosts().map((post) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  post['image']!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            post['title']!,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            post['status']!,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        post['price']!,
                        style: const TextStyle(fontSize: 14, color: Colors.red),
                      ),
                      const SizedBox(height: 4),
                      Text(post['area']!),
                      Text(post['location']!),
                      if (post['status'] == 'Unpaid')
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentScreen(
                                    postTitle: post['title']!,
                                    price: post['price']!,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            child: const Text('Pay Now - 10.000đ/bài đăng'),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  List<Map<String, String>> getFilteredPosts() {
    List<Map<String, String>> posts = [
      {
        'title': 'POST 1',
        'price': '6.200.000đ/tháng',
        'image':
            'https://enic.vn/wp-content/uploads/2023/12/nha-tro-cho-thue.jpg',
        'area': '30 - 32m²',
        'location': 'Thụy Khuê, Tây Hồ',
        'status': 'Approved'
      },
      {
        'title': 'Post 2',
        'price': '5.000.000đ/tháng',
        'image':
            'https://enic.vn/wp-content/uploads/2023/12/nha-tro-cho-thue.jpg',
        'area': '20 - 25m²',
        'location': 'Quan Hoa, Cầu Giấy',
        'status': 'Unpaid'
      },
      {
        'title': 'Post 3',
        'price': '7.500.000đ/tháng',
        'image':
            'https://thematrixones.com.vn/wp-content/uploads/2023/01/unnamed-1.jpg',
        'area': '35 - 40m²',
        'location': 'Mễ Trì, Nam Từ Liêm',
        'status': 'Paid but Unapproved'
      },
      {
        'title': 'Post 4',
        'price': '8.000.000đ/tháng',
        'image':
            'https://thematrixones.com.vn/wp-content/uploads/2023/01/unnamed-1.jpg',
        'area': '40 - 45m²',
        'location': 'Bạch Mai, Hai Bà Trưng',
        'status': 'Approved'
      },
    ];

    if (filter == 'All') {
      return posts;
    } else {
      return posts.where((post) => post['status'] == filter).toList();
    }
  }
}
