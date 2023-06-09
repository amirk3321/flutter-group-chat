


import 'package:flutter_group_chat/features/group/data/remote_data_source/group_remote_data_source.dart';
import 'package:flutter_group_chat/features/group/domain/entities/group_entity.dart';
import 'package:flutter_group_chat/features/group/domain/entities/text_message_entity.dart';
import 'package:flutter_group_chat/features/group/domain/repositories/group_repository.dart';

class GroupRepositoryImpl implements GroupRepository {

  final GroupRemoteDataSource remoteDataSource;

  GroupRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> getCreateGroup(GroupEntity groupEntity) async =>
      remoteDataSource.getCreateGroup(groupEntity);

  @override
  Stream<List<GroupEntity>> getGroups() =>
      remoteDataSource.getGroups();

  @override
  Stream<List<TextMessageEntity>> getMessages(String channelId) =>
      remoteDataSource.getMessages(channelId);

  @override
  Future<void> sendTextMessage(TextMessageEntity textMessageEntity, String channelId) =>
      remoteDataSource.sendTextMessage(textMessageEntity, channelId);

  @override
  Future<void> updateGroup(GroupEntity groupEntity) =>
      remoteDataSource.updateGroup(groupEntity);

}