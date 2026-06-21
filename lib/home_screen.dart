import 'package:flutter/material.dart';
import 'constants.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, String>> mutualFollowers = [
    {
      'name': 'Alice Johnson',
      'image': 'https://i.pravatar.cc/150?u=alice',
      'lastMsg': 'Hey, are we still meeting today?',
      'time': '10:30 AM',
      'unread': '2'
    },
    {
      'name': 'Bob Smith',
      'image': 'https://i.pravatar.cc/150?u=bob',
      'lastMsg': 'Check out this new design!',
      'time': '9:45 AM',
      'unread': '0'
    },
    {
      'name': 'Charlie Brown',
      'image': 'https://i.pravatar.cc/150?u=charlie',
      'lastMsg': 'Thanks for the help!',
      'time': 'Yesterday',
      'unread': '0'
    },
    {
      'name': 'Diana Prince',
      'image': 'https://i.pravatar.cc/150?u=diana',
      'lastMsg': 'See you soon!',
      'time': 'Monday',
      'unread': '0'
    },
    {
      'name': 'Ethan Hunt',
      'image': 'https://i.pravatar.cc/150?u=ethan',
      'lastMsg': 'Mission accomplished.',
      'time': 'Last week',
      'unread': '0'
    },
  ];

  final List<Map<String, String>> recentCalls = [
    {'name': 'Alice Johnson', 'image': 'https://i.pravatar.cc/150?u=alice', 'time': 'Just now', 'type': 'incoming'},
    {'name': 'Bob Smith', 'image': 'https://i.pravatar.cc/150?u=bob', 'time': '10:15 AM', 'type': 'outgoing'},
    {'name': 'Charlie Brown', 'image': 'https://i.pravatar.cc/150?u=charlie', 'time': 'Yesterday', 'type': 'missed'},
    {'name': 'Diana Prince', 'image': 'https://i.pravatar.cc/150?u=diana', 'time': 'Monday', 'type': 'incoming'},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildChatsPage(),
      _buildCallsPage(),
      _buildEngagePage(),
    ];

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 ? 'Messages' : (_selectedIndex == 1 ? 'Recent Calls' : 'Engage'),
          style: const TextStyle(color: kTextPrimaryColor, fontWeight: FontWeight.w900, fontSize: 28),
        ),
        backgroundColor: kBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          _buildAppBarAction(Icons.search_rounded, () {}),
          const SizedBox(width: 8),
          Builder(
            builder: (context) => _buildAppBarAction(Icons.menu_rounded, () => Scaffold.of(context).openEndDrawer()),
          ),
          const SizedBox(width: 16),
        ],
      ),
      endDrawer: _buildDrawer(context),
      body: pages[_selectedIndex],
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildChatsPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStoriesSection(),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              itemCount: mutualFollowers.length,
              itemBuilder: (context, index) {
                final user = mutualFollowers[index];
                return _buildChatItem(user, index);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCallsPage() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        itemCount: recentCalls.length,
        itemBuilder: (context, index) {
          final call = recentCalls[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(call['image']!),
            ),
            title: Text(
              call['name']!,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: kTextPrimaryColor),
            ),
            subtitle: Row(
              children: [
                Icon(
                  call['type'] == 'incoming'
                      ? Icons.call_received_rounded
                      : (call['type'] == 'outgoing' ? Icons.call_made_rounded : Icons.call_missed_rounded),
                  size: 16,
                  color: call['type'] == 'missed' ? Colors.red : Colors.green,
                ),
                const SizedBox(width: 8),
                Text(call['time']!, style: const TextStyle(color: kTextSecondaryColor, fontSize: 14)),
              ],
            ),
            trailing: Container(
              decoration: BoxDecoration(
                color: kPrimaryLightColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.call_rounded, color: kPrimaryColor, size: 20),
                onPressed: () {},
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEngagePage() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        itemCount: mutualFollowers.length,
        itemBuilder: (context, index) {
          final user = mutualFollowers[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(user['image']!),
            ),
            title: Text(
              user['name']!,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: kTextPrimaryColor),
            ),
            subtitle: const Text('Mutual follower', style: TextStyle(color: kTextSecondaryColor, fontSize: 14)),
            trailing: GestureDetector(
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
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  gradient: kPrimaryGradient,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: kPrimaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text(
                  'Engage',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStoriesSection() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        scrollDirection: Axis.horizontal,
        itemCount: mutualFollowers.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildAddStoryItem();
          }
          final user = mutualFollowers[index - 1];
          return _buildStoryItem(user);
        },
      ),
    );
  }

  Widget _buildAddStoryItem() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: kPrimaryColor.withOpacity(0.1), width: 2),
                ),
                child: const Icon(Icons.add_rounded, color: kPrimaryColor, size: 30),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Your Story', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: kTextSecondaryColor)),
        ],
      ),
    );
  }

  Widget _buildStoryItem(Map<String, String> user) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              gradient: kPrimaryGradient,
              shape: BoxShape.circle,
            ),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(user['image']!),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(user['name']!.split(' ')[0], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: kTextPrimaryColor)),
        ],
      ),
    );
  }

  Widget _buildChatItem(Map<String, String> user, int index) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: kPrimaryLightColor,
            backgroundImage: NetworkImage(user['image']!),
          ),
          Positioned(
            right: 2,
            bottom: 2,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2.5),
              ),
            ),
          ),
        ],
      ),
      title: Text(
        user['name']!,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: kTextPrimaryColor),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          user['lastMsg']!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: user['unread'] != '0' ? kTextPrimaryColor : kTextSecondaryColor,
            fontWeight: user['unread'] != '0' ? FontWeight.w700 : FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            user['time']!,
            style: TextStyle(
              color: user['unread'] != '0' ? kPrimaryColor : kTextSecondaryColor,
              fontSize: 12,
              fontWeight: user['unread'] != '0' ? FontWeight.bold : FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          if (user['unread'] != '0')
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                gradient: kPrimaryGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                user['unread']!,
                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
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
  }

  Widget _buildAppBarAction(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Icon(icon, color: kTextPrimaryColor, size: 24),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: kPrimaryColor,
            unselectedItemColor: kTextSecondaryColor.withOpacity(0.4),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
            selectedIconTheme: const IconThemeData(size: 32),
            unselectedIconTheme: const IconThemeData(size: 28),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline_rounded),
                activeIcon: Icon(Icons.chat_bubble_rounded),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.call_outlined),
                activeIcon: Icon(Icons.call_rounded),
                label: 'Calls',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people_outline_rounded),
                activeIcon: Icon(Icons.people_rounded),
                label: 'Engage',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: kBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
      ),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(gradient: kPrimaryGradient),
            currentAccountPicture: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const CircleAvatar(
                backgroundColor: kPrimaryLightColor,
                child: Icon(Icons.person, color: kPrimaryColor, size: 40),
              ),
            ),
            accountName: const Text('John Doe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
            accountEmail: const Text('john.doe@example.com', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white70)),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _drawerItem(Icons.palette_outlined, 'Chat Themes', () {}),
                _drawerItem(Icons.notifications_outlined, 'Notifications', () {}),
                _drawerItem(Icons.settings_outlined, 'Settings', () {}),
                _drawerItem(Icons.help_outline_rounded, 'Help & Support', () {}),
              ],
            ),
          ),
          const Divider(indent: 24, endIndent: 24),
          _drawerItem(Icons.logout_rounded, 'Logout', () {
             Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          }, color: kAccentColor),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap, {Color? color}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (color ?? kPrimaryColor).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color ?? kPrimaryColor, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: color ?? kTextPrimaryColor,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
