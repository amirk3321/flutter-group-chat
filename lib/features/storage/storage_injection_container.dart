import 'package:flutter_group_chat/features/injection_container.dart';
import 'package:flutter_group_chat/features/storage/data/remote_data_source/cloud_storage_remote_data_source.dart';
import 'package:flutter_group_chat/features/storage/data/remote_data_source/cloud_storage_remote_data_source_impl.dart';
import 'package:flutter_group_chat/features/storage/data/repository/cloud_storage_repository_impl.dart';
import 'package:flutter_group_chat/features/storage/domain/repository/cloud_storage_repository.dart';
import 'package:flutter_group_chat/features/storage/domain/usecases/upload_group_image_usecase.dart';
import 'package:flutter_group_chat/features/storage/domain/usecases/upload_group_image_usecase.dart';
import 'package:flutter_group_chat/features/storage/domain/usecases/upload_profile_image_usecase.dart';

Future<void> storageInjectionContainer() async {


  ///UseCases
  sl.registerLazySingleton<UploadProfileImageUseCase>(() =>
      UploadProfileImageUseCase(repository: sl.call()));
  sl.registerLazySingleton<UploadGroupImageUseCase>(() =>
      UploadGroupImageUseCase(repository: sl.call()));

  /// Repository
  sl.registerLazySingleton<CloudStorageRepository>(
          () => CloudStorageRepositoryImpl(remoteDataSource: sl.call()));

  /// Remote DataSource
  sl.registerLazySingleton<CloudStorageRemoteDataSource>(
          () => CloudStorageRemoteDataSourceImpl(storage: sl.call()));
}
