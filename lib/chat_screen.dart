import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'constants.dart';
import 'components.dart';

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
      if (mounted) {
        setState(() {
          _isTyping = _controller.text.trim().isNotEmpty;
        });
      }
    });
    // Sample conversation for demonstration
    _messages.addAll([
      {
        'id': '1',
        'text': 'Hi! I saw the new UI components you integrated. They look very professional.',
        'isMe': false,
        'time': '10:00 AM',
        'status': 'seen'
      },
      {
        'id': '2',
        'text': 'Thanks! I focused on making the layout flexible and appealing.',
        'isMe': true,
        'time': '10:05 AM',
        'status': 'seen'
      },
      {
        'id': '3',
        'text': 'It definitely shows. The gradients and shadows are perfectly balanced.',
        'isMe': false,
        'time': '10:06 AM',
        'status': 'seen'
      },
    ]);
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
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutQuart,
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
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          final index = _messages.indexWhere((msg) => msg['id'] == messageId);
          if (index != -1) _messages[index]['status'] = 'delivered';
        });
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          final index = _messages.indexWhere((msg) => msg['id'] == messageId);
          if (index != -1) _messages[index]['status'] = 'seen';
        });
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
        FilePickerResult? result = await FilePicker.pickFiles(type: FileType.audio);
        fileName = result?.files.single.name;
      } else if (fileType == 'document') {
        FilePickerResult? result = await FilePicker.pickFiles();
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
        margin: const EdgeInsets.all(kDefaultPadding),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        decoration: BoxDecoration(
          color: kSurfaceColor,
          borderRadius: BorderRadius.circular(32),
          boxShadow: kModernShadow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: kTextSecondaryColor.withValues(alpha: 0.2),
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
          ],
        ),
      ),
    );
  }

  Widget _attachmentAction(IconData icon, Color color, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: kTextPrimaryColor)),
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
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: kTextPrimaryColor, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: kPrimaryLightColor,
                  backgroundImage: NetworkImage(widget.userImage),
                  onBackgroundImageError: (_, _) {},
                  child: const Icon(Icons.person, color: kPrimaryColor, size: 20),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: kSuccessColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: kBackgroundColor, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.userName,
                    style: const TextStyle(color: kTextPrimaryColor, fontWeight: FontWeight.w800, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text(
                    'Online Now',
                    style: TextStyle(color: kSuccessColor, fontSize: 11, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          _appBarIconButton(Icons.videocam_rounded, () {}),
          _appBarIconButton(Icons.call_rounded, () {}),
          Builder(
            builder: (context) => _appBarIconButton(Icons.more_vert_rounded, () => Scaffold.of(context).openEndDrawer()),
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
                    painter: const ModernBackgroundPainter(),
                  ),
                ),
                ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    return ProfessionalChatBubble(
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

  Widget _appBarIconButton(IconData icon, VoidCallback onTap) {
    return IconButton(
      icon: Icon(icon, color: kTextPrimaryColor, size: 22),
      onPressed: onTap,
      constraints: const BoxConstraints(),
      padding: const EdgeInsets.symmetric(horizontal: 10),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: _showAttachmentOptions,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add_rounded, color: kPrimaryColor, size: 24),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    controller: _controller,
                    maxLines: 5,
                    minLines: 1,
                    style: const TextStyle(color: kTextPrimaryColor, fontSize: 15, fontWeight: FontWeight.w600),
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(color: kTextSecondaryColor, fontWeight: FontWeight.w500),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => _sendMessage(_controller.text),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.all(14),
                  decoration: const BoxDecoration(
                    gradient: kPrimaryGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: kPrimaryColor,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    _isTyping ? Icons.send_rounded : Icons.mic_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatDrawer() {
    return Drawer(
      backgroundColor: kBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(32), bottomLeft: Radius.circular(32)),
      ),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(gradient: kPrimaryGradient),
            currentAccountPicture: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: CircleAvatar(
                backgroundColor: kPrimaryLightColor,
                backgroundImage: NetworkImage(widget.userImage),
                onBackgroundImageError: (_, _) {},
                child: const Icon(Icons.person, color: kPrimaryColor, size: 40),
              ),
            ),
            accountName: Text(widget.userName, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.white)),
            accountEmail: const Text('Online Now', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),
          ),
          ListTile(
            leading: const Icon(Icons.notifications_off_outlined, color: kPrimaryColor),
            title: const Text('Mute Notifications', style: TextStyle(fontWeight: FontWeight.w700)),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.wallpaper_rounded, color: kPrimaryColor),
            title: const Text('Chat Wallpaper', style: TextStyle(fontWeight: FontWeight.w700)),
            onTap: () {},
          ),
          const Divider(indent: 24, endIndent: 24),
          ListTile(
            leading: const Icon(Icons.block_rounded, color: kAccentColor),
            title: const Text('Block User', style: TextStyle(color: kAccentColor, fontWeight: FontWeight.w700)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class ProfessionalChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String time;
  final String? status;

  const ProfessionalChatBubble({
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
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
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
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
            child: Text(
              text,
              style: TextStyle(
                color: isMe ? Colors.white : kTextPrimaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    color: kTextSecondaryColor.withValues(alpha: 0.7),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  _buildStatusIcon(),
                ],
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildStatusIcon() {
    IconData icon;
    Color color = kTextSecondaryColor.withValues(alpha: 0.5);
    switch (status) {
      case 'sent':
        icon = Icons.check_rounded;
        break;
      case 'delivered':
        icon = Icons.done_all_rounded;
        break;
      case 'seen':
        icon = Icons.done_all_rounded;
        color = kPrimaryColor;
        break;
      default:
        icon = Icons.access_time_rounded;
    }
    return Icon(icon, size: 14, color: color);
  }
}
