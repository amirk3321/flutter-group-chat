


import 'package:flutter_group_chat/features/group/data/remote_data_source/group_remote_data_source.dart';
import 'package:flutter_group_chat/features/group/data/remote_data_source/group_remote_data_source_impl.dart';
import 'package:flutter_group_chat/features/group/data/repositories/group_repository_impl.dart';
import 'package:flutter_group_chat/features/group/domain/repositories/group_repository.dart';
import 'package:flutter_group_chat/features/group/domain/usecases/get_create_group_usecase.dart';
import 'package:flutter_group_chat/features/group/domain/usecases/get_groups_usecase.dart';
import 'package:flutter_group_chat/features/group/domain/usecases/get_messages_usecase.dart';
import 'package:flutter_group_chat/features/group/domain/usecases/send_text_message_usecase.dart';
import 'package:flutter_group_chat/features/group/domain/usecases/update_group_usecase.dart';
import 'package:flutter_group_chat/features/group/presentation/cubits/chat/chat_cubit.dart';
import 'package:flutter_group_chat/features/group/presentation/cubits/group/group_cubit.dart';
import 'package:flutter_group_chat/features/injection_container.dart';

Future<void> groupInjectionContainer() async {

  //Future Cubit/Bloc
  sl.registerFactory<GroupCubit>(() => GroupCubit(
    getGroupsUseCase: sl.call(),
    getCreateGroupUseCase: sl.call(),
    updateGroupUseCase: sl.call(),
  ));
  sl.registerFactory<ChatCubit>(() => ChatCubit(
    getMessageUseCase: sl.call(),
    sendTextMessageUseCase: sl.call(),
  ));


  //UseCases

  sl.registerLazySingleton<GetCreateGroupUseCase>(
          () => GetCreateGroupUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetGroupsUseCase>(
          () => GetGroupsUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateGroupUseCase>(
          () => UpdateGroupUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetMessageUseCase>(
          () => GetMessageUseCase(repository: sl.call()));
  sl.registerLazySingleton<SendTextMessageUseCase>(
          () => SendTextMessageUseCase(repository: sl.call()));



  //Repository
  sl.registerLazySingleton<GroupRepository>(
          () => GroupRepositoryImpl(remoteDataSource: sl.call()));

  //Remote DataSource
  sl.registerLazySingleton<GroupRemoteDataSource>(
          () => GroupRemoteDataSourceImpl(firestore: sl.call(),));
}