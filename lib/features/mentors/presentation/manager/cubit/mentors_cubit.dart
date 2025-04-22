import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/mentors_model.dart';
import '../../../data/repositories/mentors_repo_impl.dart';

part 'mentors_state.dart';

class MentorsCubit extends Cubit<MentorsState> {
  MentorsCubit(this.mentorsRepoImpl) : super(MentorsInitial());
  static MentorsCubit get(context) => BlocProvider.of(context);
  final MentorsRepoImpl mentorsRepoImpl;
  Future<void> fetchMentors()async{

    final response = await mentorsRepoImpl.fetchMentors();
    response.fold(
        (l) {
          emit(MentorsFailure(message: l));

        },
        (r) {

          emit(MentorsSuccess(mentors: r));
          log(r.toString());
        },);
  }
}
