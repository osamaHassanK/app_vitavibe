import 'dart:io';
import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final File? profileImage;
  final bool isUploading;
  final String errorMessage;
  final String? profileImageUrl;

  ProfileState({
    this.profileImage,
    this.isUploading = false,
    this.errorMessage = '',
    this.profileImageUrl,
  });

  ProfileState copyWith({
    File? profileImage,
    bool? isUploading,
    String? errorMessage,
    String? profileImageUrl,
  }) {
    return ProfileState(
      profileImage: profileImage ?? this.profileImage,
      isUploading: isUploading ?? this.isUploading,
      errorMessage: errorMessage ?? this.errorMessage,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  @override
  List<Object?> get props => [profileImage, isUploading, errorMessage,profileImageUrl];
}
