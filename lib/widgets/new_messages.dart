import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final messageController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    messageController.dispose();

  }
    sendMessage()async{
    final enteredMessage = messageController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
      
    }
    FocusScope.of(context).unfocus();
    messageController.clear();
    final User user = FirebaseAuth.instance.currentUser!;

     final userData =await  FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .get();
      await FirebaseFirestore.instance
      .collection('chat')
      .add({
        'text':enteredMessage,
        'createdAt': Timestamp.now(),
        'userId': user,
        'username': userData.data()!['username'],
        'image_url': userData.data()!['image_url']
      });
 
    }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(
        left: 15,
        right: 1,
        bottom: 14
      ),
      child: Row(
children: [
  Expanded(
    child: TextField(
      controller: messageController,
      decoration: InputDecoration(label: Text('Send a message')),
      autocorrect: true,
      enableSuggestions: true,
      textCapitalization: TextCapitalization.sentences,
    )
  ),
  IconButton(
    onPressed: (){},
     icon: Icon(
      Icons.send,
      color: Theme.of(context).colorScheme.primary,
     
     )
     )
],
      ),
      );
  }
}