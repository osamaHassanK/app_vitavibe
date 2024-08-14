import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import '../../other/firebase/add_notification/add_notification_firebase.dart';
import '../../other/notification_service/flutter_local_noti/init_function.dart';
import '../../other/notification_service/notification_service.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    on<TakeProfileImage>(_onTakeProfileImage);
    on<FetchProfileData>(_fetchProfileData);
  }

  Future<void> _onTakeProfileImage(TakeProfileImage event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(profileImage: event.imageFile, isUploading: true));

    try {
      String imageUrl = await _uploadImageToFirebaseStorage(event.imageFile);
      await _saveImageUrlToFirestore(imageUrl);
      emit(state.copyWith(isUploading: false)); // Reset isUploading to false after successful upload
    } catch (error) {
      print(error);
      emit(state.copyWith(isUploading: false, errorMessage: error.toString()));
    }
  }

  Future<String> _uploadImageToFirebaseStorage(File imageFile) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('image_${DateTime.now().millisecondsSinceEpoch}.jpg');

      await ref.putFile(imageFile);
      String imageUrl = await ref.getDownloadURL();
      final localNotification = FlutterLocalNotification();
      int id = 0;

      localNotification.showNotification(
        id++,
        "VitaVibe",
        "Profile updated successfully",
      );

      AddNotificationFirebase.addNotificationToFirebase(
          notification:
          'Profile updated successfully');
      return imageUrl;
    } catch (e) {
      throw Exception('Error uploading image to Firebase Storage: $e');
    }
  }

  Future<void> _saveImageUrlToFirestore(String imageUrl) async {
    try {

      String? userId = FirebaseAuth.instance.currentUser?.uid;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set({'profileImageUrl': imageUrl}, SetOptions(merge: true));

      debugPrint('Image URL saved to Firestore');
    } catch (e) {
      throw Exception('Error saving image URL to Firestore: $e');
    }
  }

  Future<String?> _fetchProfileData(
      FetchProfileData event, Emitter<ProfileState> emit) async {
    print('start');
    try {
      final String? userId = FirebaseAuth.instance.currentUser?.uid;
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();
      print(userId);
      if (snapshot.exists) {
        String? imageUrl = snapshot.data()?['profileImageUrl'];
        emit(state.copyWith(profileImageUrl: imageUrl));
      return imageUrl;
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching image URL: $e');
      emit(state.copyWith(errorMessage: e.toString()));
      return null;
    }
  }

}
