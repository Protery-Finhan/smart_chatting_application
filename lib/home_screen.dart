import 'package:flutter/material.dart';
import 'constants.dart';
import 'chat_screen.dart';
import 'components.dart';

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
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          const Positioned.fill(
            child: CustomPaint(
              painter: ModernBackgroundPainter(),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(),
                Expanded(
                  child: _buildPageContent(),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
      endDrawer: _buildDrawer(context),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _selectedIndex == 0 ? 'Messages' : (_selectedIndex == 1 ? 'Calls' : 'Engage'),
            style: kTitleTextStyle.copyWith(fontSize: 28),
          ),
          Row(
            children: [
              _buildAppBarAction(Icons.search_rounded, () {}),
              const SizedBox(width: 12),
              Builder(
                builder: (context) => _buildAppBarAction(
                  Icons.menu_rounded,
                  () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildChatsPage();
      case 1:
        return _buildCallsPage();
      case 2:
        return _buildEngagePage();
      default:
        return _buildChatsPage();
    }
  }

  Widget _buildChatsPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStoriesSection(),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 16),
            decoration: const BoxDecoration(
              color: kSurfaceColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 30,
                  offset: Offset(0, -10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 24, bottom: 24),
                itemCount: mutualFollowers.length,
                itemBuilder: (context, index) {
                  final user = mutualFollowers[index];
                  return _buildChatItem(user);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCallsPage() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: recentCalls.length,
        itemBuilder: (context, index) {
          final call = recentCalls[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: kPrimaryLightColor,
                  backgroundImage: NetworkImage(call['image']!),
                  onBackgroundImageError: (_, __) {},
                  child: const Icon(Icons.person, color: kPrimaryColor),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(call['name']!, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: kTextPrimaryColor)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            call['type'] == 'incoming'
                                ? Icons.call_received_rounded
                                : (call['type'] == 'outgoing' ? Icons.call_made_rounded : Icons.call_missed_rounded),
                            size: 14,
                            color: call['type'] == 'missed' ? kAccentColor : kSuccessColor,
                          ),
                          const SizedBox(width: 6),
                          Text(call['time']!, style: const TextStyle(color: kTextSecondaryColor, fontSize: 13, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.call_rounded, color: kPrimaryColor, size: 20),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEngagePage() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: mutualFollowers.length,
        itemBuilder: (context, index) {
          final user = mutualFollowers[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: kPrimaryLightColor,
                  backgroundImage: NetworkImage(user['image']!),
                  onBackgroundImageError: (_, __) {},
                  child: const Icon(Icons.person, color: kPrimaryColor),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user['name']!, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: kTextPrimaryColor)),
                      const Text('Mutual Interest', style: TextStyle(color: kTextSecondaryColor, fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                GestureDetector(
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
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: kPrimaryGradient,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: kPrimaryColor.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Engage',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Stories', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: kTextSecondaryColor)),
              Text('View All', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: kPrimaryColor.withValues(alpha: 0.8))),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
        ),
      ],
    );
  }

  Widget _buildAddStoryItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: kPrimaryLightColor,
              shape: BoxShape.circle,
              border: Border.all(color: kPrimaryColor.withValues(alpha: 0.1), width: 2),
            ),
            child: const Icon(Icons.add_rounded, color: kPrimaryColor, size: 28),
          ),
          const SizedBox(height: 8),
          const Text('You', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: kTextSecondaryColor)),
        ],
      ),
    );
  }

  Widget _buildStoryItem(Map<String, String> user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(2.5),
            decoration: const BoxDecoration(
              gradient: kPrimaryGradient,
              shape: BoxShape.circle,
            ),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: CircleAvatar(
                radius: 26,
                backgroundColor: kPrimaryLightColor,
                backgroundImage: NetworkImage(user['image']!),
                onBackgroundImageError: (_, __) {},
                child: const Icon(Icons.person, color: kPrimaryColor, size: 18),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(user['name']!.split(' ')[0], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: kTextPrimaryColor)),
        ],
      ),
    );
  }

  Widget _buildChatItem(Map<String, String> user) {
    final bool hasUnread = user['unread'] != '0';
    return InkWell(
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: kPrimaryLightColor,
                  backgroundImage: NetworkImage(user['image']!),
                  onBackgroundImageError: (_, __) {},
                  child: const Icon(Icons.person, color: kPrimaryColor, size: 30),
                ),
                Positioned(
                  right: 1,
                  bottom: 1,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user['name']!,
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: kTextPrimaryColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user['lastMsg']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: hasUnread ? kTextPrimaryColor : kTextSecondaryColor,
                      fontWeight: hasUnread ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  user['time']!,
                  style: TextStyle(
                    color: hasUnread ? kPrimaryColor : kTextSecondaryColor,
                    fontSize: 11,
                    fontWeight: hasUnread ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                if (hasUnread)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: kPrimaryGradient,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: kPrimaryColor.withValues(alpha: 0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      user['unread']!,
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarAction(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: kSurfaceColor,
          shape: BoxShape.circle,
          boxShadow: kSoftShadow,
        ),
        child: Icon(icon, color: kTextPrimaryColor, size: 22),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(0, Icons.chat_bubble_rounded, 'Chats'),
              _buildBottomNavItem(1, Icons.call_rounded, 'Calls'),
              _buildBottomNavItem(2, Icons.people_rounded, 'Engage'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? kPrimaryLightColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? kPrimaryColor : kTextSecondaryColor.withValues(alpha: 0.6),
              size: 24,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: kBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(35), bottomLeft: Radius.circular(35)),
      ),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: kPrimaryGradient,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(35)),
            ),
            currentAccountPicture: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const CircleAvatar(
                backgroundColor: kPrimaryLightColor,
                child: Icon(Icons.person, color: kPrimaryColor, size: 40),
              ),
            ),
            accountName: const Text('John Doe', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.white)),
            accountEmail: const Text('john.doe@example.com', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white70)),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _drawerItem(Icons.palette_outlined, 'Chat Themes', () {}),
                _drawerItem(Icons.notifications_outlined, 'Notifications', () {}),
                _drawerItem(Icons.settings_outlined, 'Settings', () {}),
                _drawerItem(Icons.help_outline_rounded, 'Help & Support', () {}),
              ],
            ),
          ),
          const Divider(indent: 32, endIndent: 32),
          _drawerItem(
            Icons.logout_rounded,
            'Logout',
            () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
            color: kAccentColor,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap, {Color? color}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (color ?? kPrimaryColor).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, color: color ?? kPrimaryColor, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: color ?? kTextPrimaryColor,
          fontSize: 15,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
