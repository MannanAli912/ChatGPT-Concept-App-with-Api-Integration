import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pages/chatHistoryPage.dart';
import 'feature_box.dart'; // Assuming the FeatureBox is in feature_box.dart

class MockBot extends StatefulWidget {
  const MockBot({super.key});

  @override
  State<MockBot> createState() => _MockBotState();
}

class _MockBotState extends State<MockBot> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Global key for scaffold

  ChatUser mySelf = ChatUser(id: '1', firstName: "Mannan");
  ChatUser bot = ChatUser(id: '2', firstName: "AI");

  List<ChatMessage> typingUsers = <ChatMessage>[];
  List<ChatMessage> messages = <ChatMessage>[];
  List<ChatUser> _typing = <ChatUser>[];

  final url =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyBADo9qj7ooNAJxI7GuV0FdaQpjFMWWv0g";
  final header = {'Content-Type': 'application/json'};

  getData(ChatMessage m) async {
    _typing.add(bot);
    messages.insert(0, m);
    setState(() {});

    var data1 = {
      "contents": [
        {
          "parts": [
            {"text": m.text}
          ]
        }
      ]
    };

    await http
        .post(Uri.parse(url), headers: header, body: jsonEncode(data1))
        .then((value) {
      if (value.statusCode == 200) {
        var result = jsonDecode(value.body);
        String responseText = result['candidates'][0]['content']['parts'][0]
                ['text']
            .toString()
            .split('*')
            .join();

        // Create AI message
        ChatMessage m1 = ChatMessage(
          text: responseText,
          user: bot,
          createdAt: DateTime.now(),
        );

        messages.insert(0, m1);
        setState(() {});
      } else {
        print("Error occurred");
      }
    }).catchError((e) {});

    _typing.remove(bot);
    setState(() {});
  }

  void startNewChat() {
    setState(() {
      messages.clear(); // Clear previous messages
    });
  }

  void openHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatHistoryPage(
            chatHistory: messages), // Pass current messages to history page
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width

    return Scaffold(
      key: _scaffoldKey, // Assign the global key to the scaffold
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          "ChatGPT",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState
                ?.openDrawer(); // Use the global key to open the drawer
          },
          color: Colors.white,
        ),
      ),
      drawer: Container(
        width: screenWidth * 0.5, // Set drawer width to half of the screen
        child: Drawer(
          child: Container(
            color: Colors.black, // Black background for the drawer
            child: Column(
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ChatGPT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Open History',
                    style: TextStyle(
                        color: Colors
                            .white), // White text color for better visibility
                  ),
                  onTap: () {
                    Navigator.pop(context, Colors.white); // Close the drawer
                    openHistory(); // Navigate to Chat History page
                  },
                ),
                ListTile(
                  title: const Text(
                    'New Chat',
                    style: TextStyle(
                        color: Colors
                            .white), // White text color for better visibility
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    startNewChat(); // Clear the chat and start a new chat
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Show the Feature Box only if there are no messages in the chat
          if (messages.isEmpty)
            const FeatureBox(
              color: Colors.black, // Black background
              headerText: 'ChatGPT',
              descriptionText:
                  'A smarter way to interact with AI. Ask questions, get answers, and have a chat!',
            ),
          Expanded(
            child: DashChat(
              typingUsers: _typing,
              currentUser: mySelf,
              onSend: (ChatMessage m) {
                getData(m);
              },
              messages: messages,
              inputOptions: const InputOptions(
                alwaysShowSend: true,
                cursorStyle: CursorStyle(color: Colors.black),
              ),
              messageOptions: MessageOptions(
                currentUserContainerColor: Colors.black,
                avatarBuilder: yourAvatarBuilder,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget yourAvatarBuilder(
      ChatUser user, Function? onAvatarTap, Function? onAvatarLongPress) {
    return Center(
      child: Image.asset(
        "assets/images/chatgpt_logo.png",
        height: 40,
        width: 40,
      ),
    );
  }
}
