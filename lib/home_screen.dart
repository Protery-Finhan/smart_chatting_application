import 'package:flutter/material.dart';
import 'constants.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Mock data for mutual followed users
  final List<Map<String, String>> mutualFollowers = [
    {'name': 'Alice Johnson', 'image': 'https://i.pravatar.cc/150?u=alice'},
    {'name': 'Bob Smith', 'image': 'https://i.pravatar.cc/150?u=bob'},
    {'name': 'Charlie Brown', 'image': 'https://i.pravatar.cc/150?u=charlie'},
    {'name': 'Diana Prince', 'image': 'https://i.pravatar.cc/150?u=diana'},
    {'name': 'Ethan Hunt', 'image': 'https://i.pravatar.cc/150?u=ethan'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Chat', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: kPrimaryColor,
        elevation: 4,
        automaticallyImplyLeading: false,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Chats Tab
          ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            itemCount: mutualFollowers.length,
            separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFEEEEEE)),
            itemBuilder: (context, index) {
              final user = mutualFollowers[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                leading: CircleAvatar(
                  radius: 28,
                  backgroundColor: kPrimaryColor.withOpacity(0.1),
                  child: ClipOval(
                    child: Image.network(
                      user['image']!,
                      fit: BoxFit.cover,
                      width: 56,
                      height: 56,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.person, color: kPrimaryColor, size: 30);
                      },
                    ),
                  ),
                ),
                title: Text(
                  user['name']!,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        userName: user['name']!,
                        userImage: user['image']!,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          // Calls Tab
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.call_rounded, size: 100, color: Colors.grey),
                SizedBox(height: 16),
                Text('No recent calls', style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          // Engage Tab
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.explore_rounded, size: 100, color: Colors.grey),
                SizedBox(height: 16),
                Text('Engage with Community', style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Material(
        color: kPrimaryColor,
        elevation: 10,
        child: SafeArea(
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorWeight: 4.0,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withOpacity(0.8),
            labelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            tabs: const [
              Tab(
                icon: Icon(Icons.chat_bubble_rounded, size: 28),
                text: 'Chats',
              ),
              Tab(
                icon: Icon(Icons.call_rounded, size: 28),
                text: 'Calls',
              ),
              Tab(
                icon: Icon(Icons.people_rounded, size: 28),
                text: 'Engage',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
