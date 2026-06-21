import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'constants.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String userImage;

  const ChatScreen({super.key, required this.userName, required this.userImage});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isTyping = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage(String text, {String? type}) {
    if (text.trim().isEmpty && type == null) return;

    final messageId = DateTime.now().millisecondsSinceEpoch.toString();
    
    setState(() {
      _messages.add({
        'id': messageId,
        'text': text,
        'isMe': true,
        'type': type ?? 'text',
        'time': TimeOfDay.now().format(context),
        'status': 'sent',
      });
    });
    _controller.clear();
    _scrollToBottom();

    // Simulated status updates
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          final index = _messages.indexWhere((msg) => msg['id'] == messageId);
          if (index != -1) _messages[index]['status'] = 'delivered';
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) {
        setState(() {
          final index = _messages.indexWhere((msg) => msg['id'] == messageId);
          if (index != -1) _messages[index]['status'] = 'seen';
        });
      }
    });

    // Simulated reply
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'id': DateTime.now().millisecondsSinceEpoch.toString(),
            'text': 'Cool! Thanks for sharing.',
            'isMe': false,
            'type': 'text',
            'time': TimeOfDay.now().format(context),
          });
        });
        _scrollToBottom();
      }
    });
  }

  Future<void> _pickFile(String fileType) async {
    String? fileName;
    try {
      if (fileType == 'picture') {
        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        fileName = image?.name;
      } else if (fileType == 'video') {
        final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
        fileName = video?.name;
      } else if (fileType == 'audio') {
        FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
        fileName = result?.files.single.name;
      } else if (fileType == 'document') {
        FilePickerResult? result = await FilePicker.platform.pickFiles();
        fileName = result?.files.single.name;
      }

      if (fileName != null) {
        _sendMessage("Sent a $fileType: $fileName", type: fileType);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking $fileType: $e')),
        );
      }
    }
    if (mounted && Navigator.canPop(context)) Navigator.pop(context);
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: kSurfaceColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: kModernShadow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: kTextSecondaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _attachmentAction(Icons.audiotrack_rounded, Colors.orange, 'Audio', () => _pickFile('audio')),
                _attachmentAction(Icons.insert_drive_file_rounded, Colors.blue, 'Document', () => _pickFile('document')),
                _attachmentAction(Icons.image_rounded, Colors.purple, 'Gallery', () => _pickFile('picture')),
                _attachmentAction(Icons.videocam_rounded, Colors.red, 'Video', () => _pickFile('video')),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _attachmentAction(IconData icon, Color color, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: kTextPrimaryColor)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: kTextPrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.userImage),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userName,
                  style: const TextStyle(color: kTextPrimaryColor, fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const Text(
                  'Online',
                  style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.videocam_rounded, color: kTextPrimaryColor), onPressed: () {}),
          IconButton(icon: const Icon(Icons.call_rounded, color: kTextPrimaryColor), onPressed: () {}),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.more_vert_rounded, color: kTextPrimaryColor),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      endDrawer: _buildChatDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: ChatBackgroundPainter(),
                  ),
                ),
                ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    return ModernChatBubble(
                      text: msg['text'],
                      isMe: msg['isMe'],
                      time: msg['time'],
                      status: msg['status'],
                    );
                  },
                ),
              ],
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: _showAttachmentOptions,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kPrimaryLightColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add_rounded, color: kPrimaryColor, size: 26),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: kTextPrimaryColor, fontSize: 16),
                decoration: const InputDecoration(
                  hintText: 'Type message...',
                  hintStyle: TextStyle(color: kTextSecondaryColor),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => _sendMessage(_controller.text),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                gradient: kPrimaryGradient,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isTyping ? Icons.send_rounded : Icons.mic_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatDrawer() {
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
              child: CircleAvatar(backgroundImage: NetworkImage(widget.userImage)),
            ),
            accountName: Text(widget.userName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
            accountEmail: const Text('Online', style: TextStyle(color: Colors.white70)),
          ),
          ListTile(
            leading: const Icon(Icons.notifications_off_outlined, color: kPrimaryColor),
            title: const Text('Mute Notifications', style: TextStyle(fontWeight: FontWeight.w600)),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.wallpaper_rounded, color: kPrimaryColor),
            title: const Text('Chat Wallpaper', style: TextStyle(fontWeight: FontWeight.w600)),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.block_rounded, color: kAccentColor),
            title: const Text('Block User', style: TextStyle(color: kAccentColor, fontWeight: FontWeight.w600)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class ModernChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String time;
  final String? status;

  const ModernChatBubble({
    super.key,
    required this.text,
    required this.isMe,
    required this.time,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          gradient: isMe ? kPrimaryGradient : null,
          color: isMe ? null : kSurfaceColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isMe ? 20 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isMe ? Colors.white : kTextPrimaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    color: isMe ? Colors.white70 : kTextSecondaryColor,
                    fontSize: 10,
                  ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  _buildStatusIcon(),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon() {
    IconData icon;
    Color color = Colors.white70;
    switch (status) {
      case 'sent':
        icon = Icons.check_rounded;
        break;
      case 'delivered':
        icon = Icons.done_all_rounded;
        break;
      case 'seen':
        icon = Icons.done_all_rounded;
        color = Colors.cyanAccent;
        break;
      default:
        icon = Icons.access_time_rounded;
    }
    return Icon(icon, size: 14, color: color);
  }
}

class ChatBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    // Very subtle abstract shapes for chat background
    paint.color = kPrimaryColor.withOpacity(0.02);
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.2), size.width * 0.3, paint);
    
    paint.color = kAccentColor.withOpacity(0.01);
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.6), size.width * 0.4, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
