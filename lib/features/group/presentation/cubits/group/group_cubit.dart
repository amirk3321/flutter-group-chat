import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_group_chat/features/group/domain/entities/group_entity.dart';
import 'package:flutter_group_chat/features/group/domain/usecases/get_create_group_usecase.dart';
import 'package:flutter_group_chat/features/group/domain/usecases/get_groups_usecase.dart';
import 'package:flutter_group_chat/features/group/domain/usecases/update_group_usecase.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  final GetCreateGroupUseCase getCreateGroupUseCase;
  final GetGroupsUseCase getGroupsUseCase;
  final UpdateGroupUseCase updateGroupUseCase;

  GroupCubit({
    required this.getCreateGroupUseCase,
    required this.getGroupsUseCase,
    required this.updateGroupUseCase,
  }) : super(GroupInitial());



  Future<void> getGroups()async{
    emit(GroupLoading());
    try{
      final streamResponse= getGroupsUseCase.call();
      streamResponse.listen((groups) {
        emit(GroupLoaded(groups: groups));
      });
    }on SocketException catch(_){
      emit(GroupFailure());
    }catch(_){
      emit(GroupFailure());
    }


  }

  Future<void> getCreateGroup({required GroupEntity groupEntity})async{
    try{
      await getCreateGroupUseCase.call(groupEntity);
    }on SocketException catch(_){
      emit(GroupFailure());
    }catch(_){
      emit(GroupFailure());
    }
  }

  Future<void> updateGroup({required GroupEntity groupEntity})async{
    try{
      await updateGroupUseCase.call(groupEntity);
    }on SocketException catch(_){
      emit(GroupFailure());
    }catch(_){
      emit(GroupFailure());
    }
  }


}
