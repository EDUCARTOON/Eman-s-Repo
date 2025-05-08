import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/app_shared_variables.dart';
import 'package:flutter_application_3/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/services/service_locator.dart';
import '../../data/repositories/profile_repo_impl.dart';
import 'dart:convert';

class Review {
  final String text;
  final int stars;
 final String userName;
  Review({required this.text, required this.stars,required this.userName});

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'stars': stars,
    };
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      text: json['text'] as String,
      stars: json['stars'] as int,
      userName: json['userName']
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
  bool _showWriteReview = false;
  List<Review> _reviews = [];

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

  void _submitReview(BuildContext context) {
    if (_selectedStars > 0 && controller.text.isNotEmpty) {
      setState(() {
        _reviews.add(Review(text: controller.text, stars: _selectedStars, userName: childModel?.fullName??'Anonymous user'));
        _showWriteReview = false;
        controller.clear();
        _selectedStars = 0;
        _saveReviews();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Feedback added"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please select stars and write a review."),
        ),
      );
    }
  }

  Future<void> _saveReviews() async {
    final prefs = await SharedPreferences.getInstance();
    final reviewsJson = _reviews.map((review) => jsonEncode(review.toJson())).toList();
    await prefs.setStringList('reviews', reviewsJson);
  }

  Future<void> _loadReviews() async {
    final prefs = await SharedPreferences.getInstance();
    final reviewsJson = prefs.getStringList('reviews');
    if (reviewsJson != null) {
      setState(() {
        _reviews = reviewsJson.map((json) => Review.fromJson(jsonDecode(json))).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    _loadReviews();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            ProfileCubit(profileRepository: getIt.get<ProfileRepoImpl>()),
        child: Scaffold(
            backgroundColor: const Color(0xFF9BB1E3),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                _showWriteReview ? "Write a Review" : "All Reviews",
                style: const TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _showWriteReview = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: !_showWriteReview
                              ? const Color.fromARGB(255, 239, 250, 255)
                              : Colors.grey[300],
                          padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          "All Reviews",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _showWriteReview = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _showWriteReview
                              ? const Color.fromARGB(255, 239, 250, 255)
                              : Colors.grey[300],
                          padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          "Write Review",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: _showWriteReview
                        ? Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              "Course Review",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          List.generate(5, (index) => buildStar(index)),
                        ),
                        const SizedBox(height: 8),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Write your Review",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 120,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: controller,
                            maxLines: 4,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText:
                              "Would you like to write anything about this product?",
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ElevatedButton(
                            onPressed: () => _submitReview(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                  255, 239, 250, 255),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              "Submit Review",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )
                        : _reviews.isEmpty
                        ? const Center(
                      child: Text("No reviews yet. Be the first to write one!"),
                    )
                        : ListView.builder(
                      itemCount: _reviews.length,
                      itemBuilder: (context, index) {
                        final review = _reviews[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                 Row(
                                  children: [
                                    Icon(Icons.person),
                                    SizedBox(width: 8),
                                    Text(review.userName),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: List.generate(
                                    review.stars,
                                        (i) => const Icon(Icons.star, color: Colors.amber),
                                  ) +
                                      List.generate(
                                        5 - review.stars,
                                            (i) => const Icon(Icons.star_border),
                                      ),
                                ),

                                const SizedBox(height: 8),
                                Text(review.text),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            ),
        );
    }
}