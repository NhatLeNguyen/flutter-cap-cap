import 'package:flutter/material.dart';
import 'package:untitled/post_management.dart';
import 'room.dart';
import 'profile_screen.dart';
import 'message_screen.dart';
import 'ship.dart'; // Import the new ShipScreen

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  final List<String> cities = [
    "Hà Nội",
    "Thành Phố Hồ Chí Minh",
    "Hải Phòng",
    "Cần Thơ",
    "Huế",
    "Thanh Hóa",
    "Vũng Tàu",
  ];

  final List<String> priceRanges = [
    "Giá",
    "Dưới 5 triệu",
    "Từ 5 triệu đến 10 triệu",
    "Trên 10 triệu",
  ];

  final List<String> areaRanges = [
    "Diện tích",
    "Dưới 20m²",
    "20m² - 40m²",
    "Trên 40m²",
  ];

  String selectedCity = "Hà Nội";
  String selectedPrice = "Giá";
  String selectedArea = "Diện tích";
  final TextEditingController _searchController = TextEditingController();

  final roomDetails = [
    {
      "title": "TRỐNG PHÒNG THỤY KHUÊ FULL ĐỒ XÁCH VALI VÀO Ở",
      "price": "6.200.000đ/tháng",
      "image":
          "https://i.ex-cdn.com/nhadautu.vn/files/content/2024/09/09/phong-tro-1449.jpg",
      "area": "30 - 32m²",
      "location": "Phường Thụy Khuê, Quận Tây Hồ",
    },
  ];

  List<Map<String, String>> filteredRooms = [];

  @override
  void initState() {
    super.initState();
    filteredRooms = roomDetails;
  }

  void _searchRooms(String query) {
    setState(() {
      filteredRooms = roomDetails.where((room) {
        bool matchesQuery =
            room["title"]!.toLowerCase().contains(query.toLowerCase());
        bool matchesPrice = _filterByPrice(room);
        bool matchesArea = _filterByArea(room);
        return matchesQuery && matchesPrice && matchesArea;
      }).toList();
    });
  }

  bool _filterByPrice(Map<String, String> room) {
    if (selectedPrice == "Giá ") return true;
    int price = int.parse(room["price"]!.replaceAll(RegExp(r'[^\d]'), ''));
    if (selectedPrice == "Dưới 5 triệu") {
      return price < 5000000;
    } else if (selectedPrice == "Từ 5 triệu đến 10 triệu") {
      return price >= 5000000 && price <= 10000000;
    } else if (selectedPrice == "Trên 10 triệu") {
      return price > 10000000;
    }
    return false;
  }

  bool _filterByArea(Map<String, String> room) {
    if (selectedArea == "Diện tích") return true;
    int area = int.parse(room["area"]!.split(" - ")[0]);
    if (selectedArea == "Dưới 20m²") {
      return area < 20;
    } else if (selectedArea == "20m² - 40m²") {
      return area >= 20 && area <= 40;
    } else if (selectedArea == "Trên 40m²") {
      return area > 40;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Row(
          children: [
            const Icon(Icons.location_on),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCity,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCity = newValue!;
                    });
                  },
                  items: cities.map((String city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                onChanged: _searchRooms,
                decoration: InputDecoration(
                  hintText: "Tìm kiếm phòng...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  DropdownButton<String>(
                    value: selectedPrice,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPrice = newValue!;
                      });
                    },
                    items: priceRanges.map((String price) {
                      return DropdownMenuItem<String>(
                        value: price,
                        child: Text(price),
                      );
                    }).toList(),
                  ),
                  const SizedBox(width: 16),
                  DropdownButton<String>(
                    value: selectedArea,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedArea = newValue!;
                      });
                    },
                    items: areaRanges.map((String area) {
                      return DropdownMenuItem<String>(
                        value: area,
                        child: Text(area),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'CapCap đề xuất trọ theo nhu cầu của bạn',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ..._buildRoomDetails(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Tin tức phổ biến',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 150,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Image.network(
                      "https://i.ytimg.com/vi/4pm8Exz61VU/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLA7ZqzVyAV_7yQuZCAQCN0LCZecCg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Image.network(
                      "https://i.ytimg.com/vi/qvVWABGsNIY/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBrdDkVuKf25Rp7LLdtvuqOSrwHHA",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_rounded), label: 'Video'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Tin nhắn'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_shipping), label: 'Thông báo'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cá nhân'),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.yellow,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostManagementScreen(),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MessageScreen(),
              ),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShipScreen(), // Navigate to ShipScreen
              ),
            );
          }
        },
      ),
    );
  }

  List<Widget> _buildRoomDetails() {
    return filteredRooms.map((room) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoomDetailsScreen(),
            ),
          );
        },
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                room["image"]!,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room["title"]!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      room["price"]!,
                      style: const TextStyle(fontSize: 14, color: Colors.red),
                    ),
                    const SizedBox(height: 4),
                    Text(room["area"]!),
                    Text(room["location"]!),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
