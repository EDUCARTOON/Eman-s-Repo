// import 'package:flutter/material.dart';
// import 'package:flutter_application_3/features/auth/presentation/pages/login.dart';
// import 'package:flutter_application_3/features/auth/presentation/pages/resgister.dart';

// class Signup1 extends StatelessWidget {
//   const Signup1({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[200],
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // صورة متحركة GIF
//             Image.asset(
//               'assets/img/gif-unscreen.gif', // المسار الصحيح للـ GIF
//               width: 200,
//               height: 200,
//             ),
//             const SizedBox(height: 20), // مسافة بين الصورة والنص
//             const Text(
//               "Let's you in",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 20), // مسافة بين النص
//             // أزرار تسجيل الدخول
//             TextButton.icon(
//               onPressed: () {
//                 // هنا يمكنك إضافة الإجراء لتسجيل الدخول باستخدام Google
//               },
//               icon: const Icon(Icons.mail, color: Colors.black), // أيقونة Gmail
//               label: const Text('Continue with Google',
//                   style: TextStyle(color: Colors.black)),
//               style: TextButton.styleFrom(
//                 minimumSize: const Size(200, 50),
//               ),
//             ),
//             const SizedBox(height: 10), // مسافة بين الأزرار
//             TextButton.icon(
//               onPressed: () {
//                 // هنا يمكنك إضافة الإجراء لتسجيل الدخول باستخدام Apple
//               },
//               icon: const Icon(Icons.apple, color: Colors.black),
//               label: const Text('Continue with Apple',
//                   style: TextStyle(color: Colors.black)),
//               style: TextButton.styleFrom(
//                 minimumSize: const Size(200, 50),
//               ),
//             ),
//             const SizedBox(height: 10), // مسافة بين الأزرار
//             TextButton(
//               onPressed: () {
//                 // هنا يمكنك إضافة الإجراء لتسجيل الدخول كضيف
//               },
//               style: TextButton.styleFrom(
//                 minimumSize: const Size(200, 50),
//               ),
//               child: const Text('or', style: TextStyle(color: Colors.black)),
//             ),
//             const SizedBox(height: 20), // مسافة بين الأزرار
//             // زر تسجيل الدخول مع دائرة السهم البيضاء
//             TextButton(
//               onPressed: () {
//                 // فتح صفحة Login عند الضغط على الزر
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Login()),
//                 );
//               },
//               style: TextButton.styleFrom(
//                 minimumSize: const Size(200, 50),
//                 backgroundColor: Colors.white, // لون خلفية الزر
//               ),
//               child: const Row(
//                 mainAxisAlignment:
//                     MainAxisAlignment.center, // جعل المحتوى في المنتصف
//                 children: [
//                   Text(
//                     'Sign In with Your Account',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                   SizedBox(width: 10), // مسافة بين النص والأيقونة
//                   // دائرة سوداء بداخلها سهم أبيض
//                   CircleAvatar(
//                     radius: 25, // حجم الدائرة
//                     backgroundColor: Colors.black, // لون الخلفية (دائرة سوداء)
//                     child: Icon(
//                       Icons.arrow_forward, // أيقونة السهم
//                       color: Colors.white, // لون السهم
//                       size: 20, // حجم السهم
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10), // مسافة بين الزر والنص
//             TextButton(
//               onPressed: () {
//                 // فتح صفحة Resgister عند الضغط على الزر
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Resgister()),
//                 );
//               },
//               style: TextButton.styleFrom(
//                 minimumSize: const Size(200, 50),
//               ),
//               child: const Text('Don’t have an Account? SIGN UP',
//                   style: TextStyle(color: Colors.black)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
