




import 'package:flutter_group_chat/features/group/domain/entities/text_message_entity.dart';
import 'package:flutter_group_chat/features/group/domain/repositories/group_repository.dart';

class SendTextMessageUseCase{
  final GroupRepository repository;

  SendTextMessageUseCase({required this.repository});

  Future<void> call(TextMessageEntity textMessageEntity,String channelId)async{
    return await repository.sendTextMessage(textMessageEntity,channelId);
  }
}