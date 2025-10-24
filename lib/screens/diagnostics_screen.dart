import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DiagnosticsScreen extends StatefulWidget {
  const DiagnosticsScreen({super.key});

  @override
  State<DiagnosticsScreen> createState() => _DiagnosticsScreenState();
}

class _DiagnosticsScreenState extends State<DiagnosticsScreen> {
  Uint8List? _imageBytes;
  bool _loading = false;
  String? _result;
  final List<_ChatMessage> _chatMessages = [];
  final TextEditingController _chatController = TextEditingController();
  bool _showChat = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final source = await showModalBottomSheet<ImageSource?>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery / Files'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;

    setState(() => _loading = true);
    try {
      final file = await picker.pickImage(source: source, maxWidth: 1024, maxHeight: 1024, imageQuality: 85);
      if (file == null) return setState(() => _loading = false);
      final bytes = await file.readAsBytes();
      setState(() {
        _imageBytes = bytes;
        _loading = false;
        _result = null;
      });
    } catch (_) {
      setState(() => _loading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to pick image')));
    }
  }

  Future<void> _analyze() async {
    if (_imageBytes == null) return;
    setState(() {
      _loading = true;
      _result = null;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _loading = false;
      _result = 'Low risk. Monitor at home. If redness spreads or pain increases, seek care.';
    });
  }

  void _sendChatMessage() {
    if (_chatController.text.trim().isEmpty) return;
    
    final userMessage = _ChatMessage(
      text: _chatController.text.trim(),
      isUser: true,
      timestamp: DateTime.now(),
    );
    
    setState(() {
      _chatMessages.add(userMessage);
      _chatController.clear();
    });

    // Simulate AI response
    Future.delayed(const Duration(seconds: 1), () {
      final aiResponse = _ChatMessage(
        text: _getAIResponse(userMessage.text),
        isUser: false,
        timestamp: DateTime.now(),
      );
      setState(() {
        _chatMessages.add(aiResponse);
      });
    });
  }

  String _getAIResponse(String userMessage) {
    final message = userMessage.toLowerCase();
    if (message.contains('diabetes') || message.contains('blood sugar')) {
      return 'For diabetes management, monitor your blood glucose levels regularly, maintain a balanced diet with controlled carbohydrates, and stay physically active. Always consult your healthcare provider for personalized advice.';
    } else if (message.contains('blood pressure') || message.contains('hypertension')) {
      return 'For blood pressure management, reduce sodium intake, maintain a healthy weight, exercise regularly, and limit alcohol consumption. Regular monitoring and medication adherence are crucial.';
    } else if (message.contains('heart') || message.contains('cardiovascular')) {
      return 'For heart health, focus on a heart-healthy diet rich in fruits, vegetables, and lean proteins. Regular exercise, stress management, and avoiding smoking are essential.';
    } else if (message.contains('medication') || message.contains('drug')) {
      return 'Always take medications as prescribed by your doctor. Set reminders, keep a medication list, and never stop taking medications without consulting your healthcare provider.';
    } else {
      return 'I understand you\'re asking about health concerns. For personalized medical advice, please consult with your healthcare provider. I can provide general health information, but specific medical decisions should be made with your doctor.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Diagnostics'),
        backgroundColor: Colors.red.shade50,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red.shade50,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.health_and_safety,
                          size: 48,
                          color: Colors.red.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'AI-Powered Health Assessment',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade700,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Upload a skin or wound image for instant AI analysis',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (_imageBytes != null) ...[
                  Card(
                    elevation: 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(
                        _imageBytes!,
                        width: 280,
                        height: 280,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: _loading ? null : _pickImage,
                        icon: _loading 
                            ? const SizedBox(
                                width: 20, 
                                height: 20, 
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              ) 
                            : const Icon(Icons.camera_alt),
                        label: Text(_loading ? 'Loading...' : 'Upload Image'),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.red.shade600,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    if (_imageBytes != null) ...[
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: _loading ? null : _analyze,
                          icon: _loading 
                              ? const SizedBox(
                                  width: 20, 
                                  height: 20, 
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                ) 
                              : const Icon(Icons.analytics),
                          label: const Text('Analyze'),
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.green.shade600,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (_result != null) ...[
                  const SizedBox(height: 24),
                  Card(
                    elevation: 4,
                    color: Colors.green.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.insights, color: Colors.green.shade600, size: 28),
                              const SizedBox(width: 12),
                              Text(
                                'Analysis Result',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade700,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.green.shade200),
                            ),
                            child: Text(
                              _result!,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.green.shade800,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.chat, color: Colors.blue.shade600),
                        title: const Text('AI Health Assistant'),
                        subtitle: const Text('Ask questions about your health'),
                        trailing: IconButton(
                          icon: Icon(_showChat ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                          onPressed: () => setState(() => _showChat = !_showChat),
                        ),
                      ),
                      if (_showChat) ...[
                        Container(
                          height: 300,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: _chatMessages.length,
                                  itemBuilder: (context, index) {
                                    final message = _chatMessages[index];
                                    return _ChatBubble(message: message);
                                  },
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _chatController,
                                      decoration: const InputDecoration(
                                        hintText: 'Ask about your health...',
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    onPressed: _sendChatMessage,
                                    icon: Icon(Icons.send, color: Colors.blue.shade600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  _ChatMessage({required this.text, required this.isUser, required this.timestamp});
}

class _ChatBubble extends StatelessWidget {
  final _ChatMessage message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: message.isUser ? Colors.blue.shade600 : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: message.isUser ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


