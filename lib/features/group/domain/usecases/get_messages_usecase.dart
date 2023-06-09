






import 'package:flutter_group_chat/features/group/domain/entities/text_message_entity.dart';
import 'package:flutter_group_chat/features/group/domain/repositories/group_repository.dart';

class GetMessageUseCase{
  final GroupRepository repository;

  GetMessageUseCase({required this.repository});

 Stream<List<TextMessageEntity>> call(String channelId){
  return repository.getMessages(channelId);
 }
}