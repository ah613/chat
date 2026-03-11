    
import 'dart:io';

import 'package:chat/widgets/user_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


final firebase  = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen
({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
 var enteredEmail = '';
 var enteredUsername = '';
  var enteredPassword = '';
  File? selectedImage;
 var isLogin = false;
 var isUpLoading = false; 

 void submit()async{
   final valid = formKey.currentState!.validate();

   if (!valid || !isLogin && selectedImage == null) {
    return ;
   }
   formKey.currentState!.save();
   try{
    setState(() {
      isUpLoading = true;
    });
   if (isLogin) {
     
   final UserCredential userCredential = await firebase.signInWithEmailAndPassword(
      email: enteredEmail,
       password: enteredPassword
   );   
   }else {

   final UserCredential userCredential = await firebase.createUserWithEmailAndPassword(
      email: enteredEmail,
       password: enteredPassword 
       );

  final Reference storageRef =FirebaseStorage.instance
      .ref()
      .child('user_image')
      .child('${userCredential.user!.uid}.jpg'); 

   await  storageRef.putFile(selectedImage!);
   storageRef.getDownloadURL();


    await  FirebaseFirestore.instance
      .collection('users')
      .doc(userCredential.user!.uid)
      .set({
        'username':enteredUsername,
        'email': enteredEmail,
        'image_url':enteredPassword
      });
   } 
    }on FirebaseAuthException catch(e){
       ScaffoldMessenger.of(context).clearSnackBars();
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message?? 'Authentication failed'))
       );
       setState(() {
         isUpLoading = false;
       });
          }
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
             Container(
              margin: EdgeInsets.only(
                top:30,
                bottom: 30,
                right: 20,
                left: 20
              ),
              width: 200,
              child: Image.asset('assets/images/chat.png'),
             ),
             Card(
              margin: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [

                    if(!isLogin)  
                      UserImageState(
                      onPickImage: (
                        File pickedImage) { 
                         selectedImage = pickedImage;
                         }),
          // Email Address
      TextFormField(
         decoration: InputDecoration(
             labelText: 'Email Address',
        ),
       keyboardType: TextInputType.emailAddress,
       autocorrect: false,
      textCapitalization: TextCapitalization.none,
       onSaved: (value) => enteredEmail = value!,
       validator: (value) {
            if (value == null || value.trim().isEmpty || !value.contains('@')){
            return 'Please enter a valid email address.';
          }
              return null;
                      
             },
            ),
            // Username
          if(!isLogin)
        TextFormField(
         decoration: InputDecoration(
             labelText: 'Username ',
        ),
       onSaved: (value) => enteredUsername = value!,
       validator: (value) {
            if (value == null || value.trim().isEmpty ){
            return 'Please enter a valid email address.';
          }
              return null;
                      
             },
            ),
            //password
                    TextFormField(
         decoration: InputDecoration(
        labelText: 'Password',
            
         ),
          obscureText: true,
          onSaved: (value) => enteredPassword = value!,
              validator: (value) {
            if (value == null || value.trim().isEmpty || value.trim().length<6){
            return 'Password must be at least 6 characters long.';
          }
              return null;
                           
                        },
                       ),
            
                       SizedBox(height: 12),
              if(!isUpLoading) CircularProgressIndicator(),
              if(!isUpLoading)
                  ElevatedButton(
                        onPressed: submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: 
                            Theme.of(context).colorScheme.primaryContainer,
                        ),
                  child: Text (isLogin ? 'Login ' : 'Sign Up')
            
                       ),
                       if(!isUpLoading)
                        TextButton(
                        onPressed: () { 
                          setState(() {
                            isLogin = !isLogin;
                          });
                         },
                      child: Text (
                        isLogin 
                         ? 'Create new account'
                         : 'I already have an account' 
                      )
            
                       )
                      ],
                    )
                  ),
                ),
              ),
             )
            ],
          ),
        ),
      ),
    );
  }
}

