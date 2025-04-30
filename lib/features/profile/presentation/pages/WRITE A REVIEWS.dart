import 'package:flutter/material.dart';
import 'package:flutter_application_3/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/service_locator.dart';
import '../../data/repositories/profile_repo_impl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ReviewPage(),
    );
  }
}

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int _selectedStars = 0;
late TextEditingController controller;
  Widget buildStar(int index) {
    return IconButton(
      icon: Icon(
        Icons.star,
        color: index < _selectedStars ? Colors.amber : Colors.grey,
      ),
      onPressed: () {
        setState(() {
          _selectedStars = index + 1;
        });
      },
    );
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => ProfileCubit(profileRepository: getIt.get<ProfileRepoImpl>()),
  child: Scaffold(
      backgroundColor: const Color(0xFF9BB1E3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          "Write a Review",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
  listener: (context, state) {
    if (state is FeedbackSuccess){
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          backgroundColor: Colors.green,
          content: Text("feedback added"),
        ),
      );
      controller.clear();
    }else if(state is FeedbackFailure){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("feedback failed,try again"),

        ),
      );
    }
  },
  builder: (BuildContext context, ProfileState state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.black,
                ),
                const SizedBox(width: 5),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Education", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("alphabet", style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) => buildStar(index)),
          ),
          const SizedBox(height: 5),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Write your Review", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 5),
          Container(
            height:150,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child:  TextField(
              controller: controller,
              maxLines: 4,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Would you like to write anything about this Product?",
              ),
            ),
          ),
          const SizedBox(height:15),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: () {
                ProfileCubit.get(context).setFeedback(note: controller.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 239, 250, 255),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Submit Review",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  },
),
    ),
);
  }
}