import 'package:dartz/dartz.dart';



import '../../domain/repositories/mentors_repo.dart';
import '../data_sources/mentors_remote_datasources.dart';
import '../models/mentors_model.dart';

class MentorsRepoImpl implements MentorsRepo {
  final MentorsRemoteDataSource mentorsRemoteDataSource;

  MentorsRepoImpl({required this.mentorsRemoteDataSource});

  @override
  Future <Either<String, List<MentorsModel>>> fetchMentors() async{

    try {

      final mentors = await mentorsRemoteDataSource.fetchMentors();

      if (mentors == null) {
        return right([]);
      }

      // Properly handle the casting for each course entry
      return right(
        mentors.entries.map((entry) {
          // Ensure that the data is properly cast to Map<String, dynamic>
          final itemMap = Map<String, dynamic>.from(entry.value as Map);
          return MentorsModel.fromMap(itemMap);
        }).toList(),
      );
    } catch (e) {
      print(e.toString());
      return left(e.toString());
    }
  }
}
