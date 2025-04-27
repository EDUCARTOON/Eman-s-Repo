import 'package:flutter/material.dart';
import 'package:flutter_application_3/add_child_profile.dart';
import 'package:flutter_application_3/core/app_constant.dart';
import 'package:flutter_application_3/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_application_3/features/profile/presentation/pages/EditProfile.dart';
import 'package:flutter_application_3/features/profile/presentation/pages/TermsConditions.dart';
import 'package:flutter_application_3/features/profile/presentation/pages/invite%20friends.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/routing/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isDarkMode = await _getThemePreference();
  runApp(MyApp(isDarkMode: isDarkMode));
}

Future<bool> _getThemePreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isDarkMode') ?? false;
}

class MyApp extends StatelessWidget {
  final bool isDarkMode;

  const MyApp({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Profile2Page(onDarkModeToggle: () {}),
    );
  }
}

class Profile2Page extends StatefulWidget {
  const Profile2Page({super.key, required Null Function() onDarkModeToggle});

  @override
  State<Profile2Page> createState() => _Profile2PageState();
}

class _Profile2PageState extends State<Profile2Page> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  void _saveTheme(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDark);
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
    _saveTheme(isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF93AACF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF93AACF),
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => const EducartoonScreen(courseTitle: '', course: null),
        //       ),
        //     );
        //   },
        // ),
        title: const Text("Profile", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, size: 40, color: Colors.white),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.image, color: Colors.teal, size: 18),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                const Text("Educartoon", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Text("eduhub946@gmail.com", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                _buildProfileOption(context, Icons.person, "Edit Profile"),
                _buildProfileOption(context, Icons.language, "Language", trailing: const Text("English (US)", style: TextStyle(color: Colors.blue))),
                _buildProfileOption(context, Icons.security, "Terms & Conditions"),
                _buildProfileOption(context, Icons.mail, "Invite Friends"),
                _buildProfileOption(context, Icons.child_care, "Add new child"),
                _buildProfileOption(context, Icons.logout, "Logout"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context,
    IconData icon,
    String title, {
    Widget? trailing,
    Color iconColor = Colors.black,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap ?? () => _navigateTo(context, title),
    );
  }

  void _navigateTo(BuildContext context, String title) {
    if (title == "Edit Profile") {
      context.push(Routes.editProfileScreen);
     // Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileApp()));
    } else if (title == "Terms & Conditions") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const TermsConditionsApp()));
    } else if (title == "Logout") {
     context.go(Routes.loginScreen);
    }
    else if (title == "Invite Friends") {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  InviteFriendsApp()));
    } else if (title == "Add new child") {
      //context.go(Routes.addChildProfile);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AddChildProfileScreen()));
    } else if (title == "Logout") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    } else if (title == "Dark Mode") {
      toggleTheme();
    }
  }
}

