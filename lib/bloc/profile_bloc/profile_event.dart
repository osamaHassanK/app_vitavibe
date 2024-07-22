import 'dart:io';

abstract class ProfileEvent {}

class TakeProfileImage extends ProfileEvent {
  final File imageFile;

  TakeProfileImage(this.imageFile);
}

class FetchProfileData extends ProfileEvent {
  FetchProfileData();

  List<Object?> get props => [];
}