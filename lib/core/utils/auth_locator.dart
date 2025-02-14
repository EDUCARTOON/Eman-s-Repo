import 'package:flutter_application_3/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:flutter_application_3/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:get_it/get_it.dart';


final getIt=GetIt.instance;
void setupLocator(){
  getIt.registerSingleton<AuthRepository>(AuthRepository
    (remoteDataSource: RemoteDataSource(),));

   

}
