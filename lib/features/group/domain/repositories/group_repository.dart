


import 'package:flutter_group_chat/features/group/domain/entities/group_entity.dart';
import 'package:flutter_group_chat/features/group/domain/entities/text_message_entity.dart';

abstract class GroupRepository{
  Future<void> getCreateGroup(GroupEntity groupEntity);
  Future<void> updateGroup(GroupEntity groupEntity);
  Stream<List<GroupEntity>> getGroups();
  Future<void> sendTextMessage(TextMessageEntity textMessageEntity,String channelId);
  Stream<List<TextMessageEntity>> getMessages(String channelId);
}