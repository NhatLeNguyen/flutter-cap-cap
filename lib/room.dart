import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          RoomDetailsScreen(), // Make sure you're starting from RoomDetailsScreen
    );
  }
}

class RoomDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> fakeDetails = {
    "price": "Giá: 6.200.000/tháng",
    "contactName": "Như Quỳnh",
    "contactPhone": "+84 819 656 907",
    "contactSL": "3 người",
    "contactDC": "số nhà 5A,ngách 27,Thụy Khuê",
    "amenities": <String, bool>{
      "WiFi": true,
      "WC riêng": true,
      "Giữ xe": true,
      "Giờ giấc tự do": false,
      "Bếp": true,
      "Điều hòa": true,
      "Tủ lạnh": false,
      "Máy giặt": true,
      "Thú cưng": false,
    },
    "images": <String>[
      "https://1.bp.blogspot.com/-IzomIboZzm8/X2zfcsk5XBI/AAAAAAAACIk/zBHl17sc4q4a-d-zIEGO8tTrt_5ecNriQCPcBGAsYHg/s1242/IMG_1883.JPG",
      "https://hita.com.vn/public/upload/images/another/images/thiet-bi-ve-sinh-cho-phong-tro.jpg",
      "https://edeninterior.vn/wp-content/uploads/2022/04/decor-bep-phong-tro-10.jpg",
    ],
  };

  RoomDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết phòng"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: PageView.builder(
                  itemCount: (fakeDetails["images"] as List<String>).length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.network(
                        (fakeDetails["images"] as List<String>)[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              Text(
                fakeDetails["price"]!,
                style: TextStyle(fontSize: 16),
              ),
              Text("Liên hệ: ${fakeDetails["contactName"]}"),
              Text("Số điện thoại: ${fakeDetails["contactPhone"]}"),
              Text("Số lượng người: ${fakeDetails["contactSL"]}"),
              Text("Địa chỉ: ${fakeDetails["contactDC"]}"),
              Text("Đăng 3 ngày trươc"),
              SizedBox(height: 12),
              Text(
                "Tình trạng: Đang còn",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                "Tiện ích:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Column(
                children: (fakeDetails["amenities"] as Map<String, bool>)
                    .entries
                    .map((entry) {
                  return Row(
                    children: [
                      Icon(
                        entry.value ? Icons.check_circle : Icons.cancel,
                        color: entry.value ? Colors.green : Colors.red,
                      ),
                      SizedBox(width: 8),
                      Text(entry.key),
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Wrap(
                spacing: 16.0,
                runSpacing: 8.0,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen()),
                      );
                    },
                    icon: Icon(Icons.message),
                    label: Text("Nhắn tin chủ trọ"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RoommateListScreen()),
                      );
                    },
                    icon: Icon(Icons.search),
                    label: Text("Người quan tâm"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showInterestDialog(context);
                    },
                    icon: Icon(Icons.group_add),
                    label: Text("Quan tâm"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showInterestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Đăng ký tìm bạn trọ"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: "Tên"),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Tuổi"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Nghề nghiệp"),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Quê quán"),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Tình trạng"),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Số điện thoại"),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Thoát"),
            ),
            ElevatedButton(
              onPressed: () {
                // Xử lý đăng ký
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Đăng ký thành công!")),
                );
              },
              child: Text("Đăng ký"),
            ),
          ],
        );
      },
    );
  }
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final messages = [
      {"sender": "Bạn", "text": "Chào anh/chị, phòng còn trống không?"},
      {"sender": "Chủ trọ", "text": "Chào bạn, phòng vẫn còn nhé."},
      {"sender": "Bạn", "text": "Phòng có giữ xe không ạ?"},
      {"sender": "Chủ trọ", "text": "Có giữ xe an toàn trong nhà nhé."},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat với chủ trọ"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isUser = message["sender"] == "Bạn";
                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.orange[100] : Colors.blue[100],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        "${message['sender']}: ${message['text']}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Nhập tin nhắn...",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.send),
              ),
              onSubmitted: (text) {},
            ),
          ],
        ),
      ),
    );
  }
}

class RoommateListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> roommates = List.generate(
    10,
    (index) => {
      "avatar": "https://randomuser.me/api/portraits/men/$index.jpg",
      "name": "Người dùng $index",
      "age": 20 + index,
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách người quan tâm"),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: roommates.length,
        itemBuilder: (context, index) {
          final roommate = roommates[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(roommate["avatar"]),
            ),
            title: Text(roommate["name"]),
            subtitle: Text("Tuổi: ${roommate['age']}"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RoommateDetailsScreen(roommate: roommate),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class RoommateDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> roommate;

  RoommateDetailsScreen({required this.roommate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin người quan tâm"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(roommate["avatar"]),
              ),
            ),
            SizedBox(height: 16),
            Text("Tên: ${roommate['name']}", style: TextStyle(fontSize: 18)),
            Text("Tuổi: ${roommate['age']}", style: TextStyle(fontSize: 18)),
            Text("Nghề nghiệp: Sinh viên năm cuối",
                style: TextStyle(fontSize: 18)),
            Text("Quê quán: Hà Nội", style: TextStyle(fontSize: 18)),
            Text("Tình trạng: Đang cần tìm thêm 2 bạn cùng phòng",
                style: TextStyle(fontSize: 18)),
            Text("Thời gian đăng ký: 2 ngày trước",
                style: TextStyle(fontSize: 18)),
            Text("Số điện thoại: +84 912 345 678",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        GroupChatScreen(roommateName: roommate['name']),
                  ),
                );
              },
              icon: Icon(Icons.group),
              label: Text("Tạo nhóm với chủ nhà"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(),
                  ),
                );
              },
              icon: Icon(Icons.message),
              label: Text("Nhắn tin"),
            ),
          ],
        ),
      ),
    );
  }
}

class GroupChatScreen extends StatelessWidget {
  final String roommateName;

  GroupChatScreen({required this.roommateName});

  @override
  Widget build(BuildContext context) {
    final messages = [
      {
        "sender": "Chủ nhà",
        "text": "Chào bạn $roommateName, rất vui khi có bạn tham gia nhóm!"
      },
      {
        "sender": "$roommateName",
        "text": "Cảm ơn anh/chị. Tôi rất quan tâm đến phòng này."
      },
      {"sender": "Chủ nhà", "text": "Tôi rất mong được cộng tác."},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Nhóm chat"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isUser = message["sender"] == roommateName;
                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.green[100] : Colors.blue[100],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        "${message['sender']}: ${message['text']}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Nhập tin nhắn...",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.send),
              ),
              onSubmitted: (text) {},
            ),
          ],
        ),
      ),
    );
  }
}
