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
    super.dispose();
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
        'status': 'sent', // Initial status: Single tick
      });
    });
    _controller.clear();

    // Simulate delivery update (Double tick)
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          final index = _messages.indexWhere((msg) => msg['id'] == messageId);
          if (index != -1) {
            _messages[index]['status'] = 'delivered';
          }
        });
      }
    });

    // Simulate seen update (Green double tick)
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          final index = _messages.indexWhere((msg) => msg['id'] == messageId);
          if (index != -1) {
            _messages[index]['status'] = 'seen';
          }
        });
      }
    });

    // Mock reply
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'id': DateTime.now().millisecondsSinceEpoch.toString(),
            'text': 'Received your ${type ?? 'message'}!',
            'isMe': false,
            'type': 'text',
            'time': TimeOfDay.now().format(context),
          });
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
    
    if (mounted) Navigator.pop(context);
  }

  void _showAttachmentOptions() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 12, bottom: 85),
            width: MediaQuery.of(context).size.width * 0.11, // Reduced to half of original (from 0.22)
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 15,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _attachmentItem(Icons.audiotrack, Colors.orange, () => _pickFile('audio')),
                  _attachmentItem(Icons.insert_drive_file, Colors.blue, () => _pickFile('document')),
                  _attachmentItem(Icons.image, Colors.purple, () => _pickFile('picture')),
                  _attachmentItem(Icons.videocam, Colors.red, () => _pickFile('video')),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 0.1), end: const Offset(0, 0)).animate(anim1),
          child: FadeTransition(opacity: anim1, child: child),
        );
      },
    );
  }

  Widget _attachmentItem(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Center(
          child: Icon(icon, color: color, size: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: kPrimaryColor,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white24,
              child: ClipOval(
                child: Image.network(
                  widget.userImage,
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person, color: Colors.white, size: 24);
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              widget.userName,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return ChatBubble(
                  text: msg['text'],
                  isMe: msg['isMe'],
                  type: msg['type'],
                  time: msg['time'],
                  status: msg['status'],
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add_circle_rounded, color: kPrimaryColor, size: 42),
                  onPressed: _showAttachmentOptions,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: kPrimaryColor, width: 2.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: kPrimaryColor, width: 3.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (!_isTyping)
                  IconButton(
                    icon: const Icon(Icons.mic, color: kPrimaryColor, size: 34),
                    onPressed: () => _sendMessage('Sent a voice note', type: 'voice_note'),
                  ),
                if (_isTyping)
                  IconButton(
                    icon: const Icon(Icons.send, color: kPrimaryColor, size: 34),
                    onPressed: () => _sendMessage(_controller.text),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String type;
  final String time;
  final String? status;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isMe,
    required this.type,
    required this.time,
    this.status,
  });

  IconData _getIcon() {
    switch (type) {
      case 'audio': return Icons.audiotrack;
      case 'document': return Icons.insert_drive_file;
      case 'picture': return Icons.image;
      case 'video': return Icons.videocam;
      case 'voice_note': return Icons.mic;
      default: return Icons.chat;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? kPrimaryColor : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
            bottomRight: isMe ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (type != 'text')
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(_getIcon(), size: 18, color: isMe ? Colors.white : Colors.black87),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      text,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              )
            else
              Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black87,
                  fontSize: 16,
                ),
              ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    color: isMe ? Colors.white70 : Colors.black54,
                    fontSize: 10,
                  ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  Icon(
                    (status == 'delivered' || status == 'seen') ? Icons.done_all : Icons.check,
                    size: 14,
                    color: status == 'seen' 
                        ? Colors.lightGreenAccent 
                        : (isMe ? Colors.white70 : Colors.black54),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
