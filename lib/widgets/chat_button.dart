import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void showChatForm(BuildContext context) {
  final TextEditingController controller = TextEditingController();
  bool isLoading = false;
  String response = '';

  showDialog(
    context: context,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            titlePadding: const EdgeInsets.only(top: 20),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // LOGINIZER tetap di tengah
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/loginizer_ai.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'LOGINIZER',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                /// ✅ Subtitle rata kanan, lebar fleksibel
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ), // ✅ kiri-kanan seimbang
                    child: const Text(
                      'This is not a chat with Truck Drivers, OcO, or Shipping Lines.\n'
                      'This is your gateway to structured port logistics knowledge.',
                      textAlign: TextAlign.justify, // ✅ Rata kiri-kanan
                      style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
            content: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380, minHeight: 320),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Type your question here...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(14),
                    ),
                    style: const TextStyle(fontSize: 14),
                    minLines: 5, // ✅ Lebih tinggi
                    maxLines: 6,
                  ),
                  const SizedBox(height: 16),
                  isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final text = controller.text.trim();
                              if (text.isEmpty) return;

                              // ✅ Hilangkan keyboard
                              FocusScope.of(context).unfocus();

                              setState(() {
                                isLoading = true;
                                response = '';
                              });

                              final uri = Uri.parse(
                                'https://rudysangian.com/chat',
                              );
                              final responseHttp = await http.post(
                                uri,
                                headers: {'Content-Type': 'application/json'},
                                body: jsonEncode({
                                  "messages": [
                                    {
                                      "role": "system",
                                      "content":
                                          "You are a port logistics consultant. Reply in the same language as the user's question (English or Indonesian). Always keep the answer short.",
                                    },
                                    {"role": "user", "content": text},
                                  ],
                                }),
                              );

                              if (responseHttp.statusCode == 200) {
                                final data = jsonDecode(responseHttp.body);
                                setState(() {
                                  response = data['content'];
                                });
                              } else {
                                setState(() {
                                  response =
                                      '⚠️ Error: ${responseHttp.statusCode}';
                                });
                              }

                              setState(() => isLoading = false);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            child: const Text('Submit'),
                          ),
                        ),
                  const SizedBox(height: 14),
                  if (response.isNotEmpty)
                    Text(
                      response,
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.left,
                    ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    },
  );
}

class ChatButton extends StatelessWidget {
  const ChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      right: 24,
      child: FloatingActionButton(
        onPressed: () => showChatForm(context),
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.chat_bubble_outline),
      ),
    );
  }
}
