import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_chat/features/group/domain/entities/group_entity.dart';
import 'package:flutter_group_chat/features/group/domain/entities/single_chat_entity.dart';
import 'package:flutter_group_chat/features/group/domain/entities/text_message_entity.dart';
import 'package:flutter_group_chat/features/group/presentation/cubits/chat/chat_cubit.dart';
import 'package:flutter_group_chat/features/group/presentation/cubits/group/group_cubit.dart';
import 'package:intl/intl.dart';

class SingleChatPage extends StatefulWidget {
  final SingleChatEntity singleChatEntity;

  const SingleChatPage({Key? key, required this.singleChatEntity})
      : super(key: key);

  @override
  State<SingleChatPage> createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  TextEditingController _messageController = TextEditingController();

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context)
        .getMessages(channelId: widget.singleChatEntity.groupId);
    _messageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.singleChatEntity.groupName}"),
      ),
      body: Stack(
        children: [
          Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                "assets/background_wallpaper.png",
                fit: BoxFit.cover,
              )),
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, chatState) {
              if (chatState is ChatLoaded) {
                final messages = chatState.messages;
                return Column(
                  children: [
                    _messageListWidget(messages),
                    _sendMessageTextField(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }

  Widget _messageLayout({
    required String text,
    required String time,
    required Color color,
    required TextAlign align,
    required CrossAxisAlignment boxAlign,
    required CrossAxisAlignment crossAlign,
    required String name,
    required TextAlign alignName,
    required BubbleNip nip,
  }) {
    return Column(
      crossAxisAlignment: crossAlign,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.90,
          ),
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(3),
            child: Bubble(
              color: color,
              nip: nip,
              child: Column(
                crossAxisAlignment: crossAlign,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$name",
                    textAlign: alignName,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    text,
                    textAlign: align,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    time,
                    textAlign: align,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(
                        .4,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  _sendMessageTextField() {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      offset: Offset(0.0, 0.50),
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ]),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.insert_emoticon,
                    color: Colors.grey[500],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(maxHeight: 60),
                      child: Scrollbar(
                        child: TextField(
                          style: TextStyle(fontSize: 14),
                          controller: _messageController,
                          maxLines: null,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type a message"),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.link,
                        color: Colors.grey[500],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      _messageController.text.isEmpty
                          ? Icon(
                              Icons.camera_alt,
                              color: Colors.grey[500],
                            )
                          : Text(""),
                    ],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              if (_messageController.text.isEmpty) {
                //TODO:send voice message
              } else {
                BlocProvider.of<ChatCubit>(context)
                    .sendTextMessage(
                        textMessageEntity: TextMessageEntity(
                            time: Timestamp.now(),
                            content: _messageController.text,
                            senderName: widget.singleChatEntity.username,
                            senderId: widget.singleChatEntity.uid,
                            type: "TEXT"),
                        channelId: widget.singleChatEntity.groupId)
                    .then((value) {
                  BlocProvider.of<GroupCubit>(context).updateGroup(
                      groupEntity: GroupEntity(
                    groupId: widget.singleChatEntity.groupId,
                    lastMessage: _messageController.text,
                    createAt: Timestamp.now(),
                  ));
                  _clear();
                });
              }
            },
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Icon(
                _messageController.text.isEmpty ? Icons.mic : Icons.send,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _clear() {
    setState(() {
      _messageController.clear();
    });
  }

  _messageListWidget(List<TextMessageEntity> messages) {
    if (_scrollController.hasClients) {
      Timer(Duration(milliseconds: 100), () {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      });
    }

    return Expanded(
        child: ListView.builder(
      itemCount: messages.length,
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) {
        final singleMessage = messages[index];

        if (singleMessage.senderId == widget.singleChatEntity.uid)
          return _messageLayout(
            name: "Me",
            alignName: TextAlign.end,
            color: Colors.lightGreen,
            time: DateFormat('hh:mm a').format(singleMessage.time!.toDate()),
            align: TextAlign.left,
            nip: BubbleNip.rightTop,
            boxAlign: CrossAxisAlignment.start,
            crossAlign: CrossAxisAlignment.end,
            text: singleMessage.content!,
          );
        else
          return _messageLayout(
            color: Colors.white,
            nip: BubbleNip.leftTop,
            name: "${singleMessage.senderName}",
            alignName: TextAlign.end,
            time: DateFormat('hh:mm a').format(singleMessage.time!.toDate()),
            align: TextAlign.left,
            boxAlign: CrossAxisAlignment.start,
            crossAlign: CrossAxisAlignment.start,
            text: singleMessage.content!,
          );
      },
    ));
  }
}
