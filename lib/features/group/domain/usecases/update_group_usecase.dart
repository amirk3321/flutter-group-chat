





import 'package:flutter_group_chat/features/group/domain/entities/group_entity.dart';
import 'package:flutter_group_chat/features/group/domain/repositories/group_repository.dart';

class UpdateGroupUseCase{
  final GroupRepository repository;

  UpdateGroupUseCase({required this.repository});
  Future<void> call(GroupEntity groupEntity){
    return repository.updateGroup(groupEntity);
  }

}