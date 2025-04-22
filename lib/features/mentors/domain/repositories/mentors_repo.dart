import 'package:dartz/dartz.dart';


import '../../data/models/mentors_model.dart';

abstract class MentorsRepo {
 Future <Either<String, List<MentorsModel>>> fetchMentors();
}