import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/routing/routes.dart';
import 'package:flutter_application_3/features/on_boarding/presentation/splash/splash1.dart';
import 'package:go_router/go_router.dart'; // تأكد من استيراد صفحة Splash1

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner : false,
      home: Scaffold(
        backgroundColor:  const Color(0xFF93AACF), // لون الخلفية
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // جعل العناصر تبدأ من الأعلى
            crossAxisAlignment: CrossAxisAlignment.center, // جعل العناصر تكون في المنتصف أفقياً
            children: [
              // زر "Skip"
              Padding(
                padding: const EdgeInsets.only(top: 40), // مسافة من الأعلى ليظهر الزر بوضوح
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      // فتح صفحة Splash1 عند الضغط على الزر
                       context.push(Routes.splash1sScreen);
                             
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const Splash1()),
                      // );
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              // الصورة
              const SizedBox(height: 30), // تقليل المسافة بين الزر والصورة
              Image.asset(
                'assets/img/Premium_Vector___A_cartoon_of_a_boy_reading_a_book-removebg-preview.png', // استخدم مسار الصورة الخاص بك
                width: 400, // عرض الصورة
              ),
              const SizedBox(height: 30), // مسافة بين الصورة والنص
              const Text(
                'Online Learning ',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10), // مسافة بين النص والنص التالي
              const Text(
                'We Provide Classes Online, Classes and Pre Recorded Lectures!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 40), // مسافة إضافية قبل السهم
          
              // زر السهم داخل دائرة سوداء وتحريكها لليمين
              Align(
                alignment: Alignment.centerRight, // تحريك السهم إلى اليمين
                child: Padding(
                  padding: const EdgeInsets.only(right: 30), // إضافة مسافة من الجهة اليمنى
                  child: GestureDetector(
                    onTap: () {
                       context.push(Routes.splash1sScreen);
          
                      // الانتقال إلى الصفحة التالية عند الضغط على السهم
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const Splash1()), // قم بتغيير الصفحة هنا
                      // );
                    },
                    child: const CircleAvatar(
                      radius: 30, // حجم الدائرة
                      backgroundColor: Colors.black, // لون الخلفية (دائرة سوداء)
                      child: Icon(
                        Icons.arrow_forward, // أيقونة السهم
                        color: Colors.white, // لون السهم
                        size: 30, // حجم السهم
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


