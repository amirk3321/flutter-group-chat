import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_group_chat/features/user/domain/entities/user_entity.dart';
import 'package:flutter_group_chat/features/user/domain/usercases/get_all_users_usecase.dart';
import 'package:flutter_group_chat/features/user/domain/usercases/get_update_user_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetAllUsersUseCase getAllUsersUseCase;
  final GetUpdateUserUseCase getUpdateUserUseCase;
  UserCubit({required this.getAllUsersUseCase,required this.getUpdateUserUseCase}) : super(UserInitial());


  Future<void> getUsers({required UserEntity user})async{
    emit(UserLoading());
    try{
      final streamResponse= getAllUsersUseCase.call(user);
      streamResponse.listen((users) {
        emit(UserLoaded(users: users));
      });
    }on SocketException catch(_){
      emit(UserFailure());
    }catch(_){
      emit(UserFailure());
    }
  }

  Future<void> getUpdateUser({required UserEntity user})async{
    try{
      await getUpdateUserUseCase.call(user);
    }on SocketException catch(_){
      emit(UserFailure());
    }catch(_){
      emit(UserFailure());
    }
  }
}
