import 'package:flutter/material.dart';
import 'package:flutter_application_3/features/profile/presentation/pages/profile1.dart';
import 'package:flutter_application_3/features/profile/presentation/pages/profile2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const InviteFriendsApp());
}

class InviteFriendsApp extends StatelessWidget {
  const InviteFriendsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InviteFriendsScreen(),
    );
  }
}

class InviteFriendsScreen extends StatelessWidget {
  final List<Map<String, String>> friends = [
    {"name": "Rani Thomas", "phone": "(+91) 702-897-7965", "invited": "false"},
    {"name": "Anastasia", "phone": "(+91) 702-897-7965", "invited": "false"},
    {"name": "Vaibhav", "phone": "(+91) 727-688-4052", "invited": "true"},
    {"name": "Rahul Juman", "phone": "(+91) 601-897-1714", "invited": "false"},
    {"name": "Abby", "phone": "(+91) 802-312-3200", "invited": "true"},
  ];

  InviteFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB0C4DE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // هنا يمكنك تحديد الصفحة التي تريد العودة إليها
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Profile2Page(onDarkModeToggle: () {  },)), // استبدال Profile2Page بالصفحة التي تريد الرجوع إليها
            );
          },
        ),
        title: const Text("Invite Friends", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(backgroundColor: Colors.black),
                  title: Text(friends[index]["name"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(friends[index]["phone"]!),
                  trailing: ElevatedButton(
                    onPressed: friends[index]["invited"] == "true" ? null : () {
                      // إضافة منطق الدعوة هنا
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: friends[index]["invited"] == "true" ? Colors.grey[300] : Colors.blue,
                    ),
                    child: const Text("Invite", style: TextStyle(color: Colors.white)),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                  onPressed: () {
                    // ignore: avoid_print
                    print("Facebook share tapped");
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.twitter, color: Colors.lightBlue),
                  onPressed: () {
                    // ignore: avoid_print
                    print("Twitter share tapped");
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                  onPressed: () {
                    // ignore: avoid_print
                    print("Google share tapped");
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
                  onPressed: () {
                    // ignore: avoid_print
                    print("WhatsApp share tapped");
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
