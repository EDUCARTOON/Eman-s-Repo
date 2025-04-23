import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/features/mentors/presentation/manager/cubit/mentors_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_constant.dart';
import '../../data/data_sources/mentors_remote_datasources.dart';
import '../../data/models/mentors_model.dart';
import '../../data/repositories/mentors_repo_impl.dart';
import 'educartoon_screen.dart';

class TopScoreScreen extends StatefulWidget {
  const TopScoreScreen({super.key,});

  @override
  // ignore: library_private_types_in_public_api
  _TopScoreScreenState createState() => _TopScoreScreenState();
}

class _TopScoreScreenState extends State<TopScoreScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> categories = [
    'Education',
    'Religion',
    'Technology',
    'Civilization',
    'Behavior',
    'Entertainment',
  ];
  
  String filteredCategories = '';
  bool isSearching = false;

  @override
  void initState() {
    super.initState();

    //filteredCategories = categories;
  }

  void _filterCategories(String query) {
    setState(() {
      // filteredCategories = categories
      //     .where((category) => category.toLowerCase().contains(query.toLowerCase()))
      //     .toList();
      filteredCategories = query;
    });
  }
  List<MentorsModel> mentors(List<MentorsModel>mentors) {
    if(filteredCategories == ''){
      return [];
    }
    var  result = mentors
          .where((element) => element.cat.toLowerCase().contains(filteredCategories.toLowerCase()))
          .toList();
    return result;

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentorsCubit(
          MentorsRepoImpl(mentorsRemoteDataSource: MentorsRemoteDataSource()))..fetchMentors(),
      child: Scaffold(
        backgroundColor: const Color(0xFF89A1C0), // لون الخلفية الأزرق
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: isSearching
              ? TextField(
                  controller: _searchController,
                  onChanged: _filterCategories,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                )
              : const Row(
                  children: [
                    Text(
                      "Top score",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.emoji_events, color: Colors.amber, size: 28), // رمز النجمة
                  ],
                ),
          actions: [
            IconButton(
              icon: Icon(isSearching ? Icons.close : Icons.search, color: Colors.black),
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  if (!isSearching) {
                    _searchController.clear();
                    filteredCategories = '';
                  }
                });
              },
            ),
          ],
        ),
        body: BlocBuilder<MentorsCubit, MentorsState>(
        builder: (context, state) {
      if (state is MentorsSuccess){
        var finalMentor = isSearching?mentors(state.mentors):state.mentors;
        return ListView.builder(
          itemCount:finalMentor.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  leading:  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: AppConstant.convertGoogleDriveUrl(finalMentor[index].img),
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                  title: Text(
                    finalMentor[index].name,
                    style: TextStyle(
                      fontSize: 14,
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  subtitle: Text(
                    finalMentor[index].cat,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.black, // الخط الفاصل بين العناصر
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
              ],
            );
          },
        );
      }else if (state is MentorsFailure){
        return const Center(child: Text('No Data yet..'),);
      
      }else {
        return const Center(child: CircularProgressIndicator(),);
      }
      
        },
      ),

      ),
    );
  }
}
