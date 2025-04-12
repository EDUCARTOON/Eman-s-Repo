import 'package:flutter_application_3/core/services/cache_helper.dart';
import 'package:flutter_application_3/core/services/secure_storage_sevice.dart';
import 'package:flutter_application_3/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:flutter_application_3/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flutter_application_3/features/layout/manager/layout_cubit.dart';
import 'package:flutter_application_3/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:flutter_application_3/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:flutter_application_3/features/profile/domain/repositories/profile_repo.dart';
import 'package:get_it/get_it.dart';


final getIt=GetIt.instance;
void setupLocator(){
  getIt.registerSingleton<AuthRepository>(AuthRepository
    (remoteDataSource: RemoteDataSource(),));

  getIt.registerSingleton<ProfileRepoImpl>(ProfileRepoImpl
    ( profileRemoteDataSource: ProfileRemoteDataSource(),));  
    getIt.registerFactory(() => LayoutCubit());
      getIt.registerSingleton<SecureStorageServices>(SecureStorageServices());
    //   getIt.registerFactory(=>SecureStorageServices
    // ());  
}
