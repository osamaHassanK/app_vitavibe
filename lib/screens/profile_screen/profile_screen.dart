import 'dart:io';
import 'package:app_vitavibe/other/Theme/colors.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../../bloc/profile_bloc/profile_bloc.dart';
import '../../bloc/profile_bloc/profile_event.dart';
import '../../bloc/profile_bloc/profile_state.dart';
import '../../other/app_dimensions/app_dimensions.dart';
import '../../other/models/reminder_model.dart';
import '../../other/widgets/glowingbuttonwidget.dart';
import '../login_screen/login_screen.dart';

class ProfileScreenView extends StatefulWidget {
  const ProfileScreenView({Key? key}) : super(key: key);

  @override
  _ProfileScreenViewState createState() => _ProfileScreenViewState();
}

class _ProfileScreenViewState extends State<ProfileScreenView> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(FetchProfileData());
    print('hello');
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = AppDimensions(context);
    String? userName = FirebaseAuth.instance.currentUser?.displayName;
    String? email = FirebaseAuth.instance.currentUser?.email;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        title: const Text('Profile', style: TextStyle(fontSize: 24,fontFamily: 'f')),
        backgroundColor: Colors.white,
       // shadowColor: Colors.white,
        //elevation: 1,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: dimensions.height*0.02),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    if(state.isUploading == true){}else{
                    _showUpdateProfileDialog(context);}
                  },
                  child: state.isUploading == true ? SizedBox(
                      height: dimensions.height*0.25,
                      width: dimensions.width*0.6,
                      child: Center(child: CircularProgressIndicator(color: AppColor.primaryColor,))):
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 100,
                    backgroundImage: state.profileImage != null && state.profileImage!.path.isNotEmpty
                        ? FileImage(state.profileImage!)
                        : (state.profileImageUrl != null
                        ? NetworkImage(state.profileImageUrl!)
                        : const AssetImage('assets/images/user.png') as ImageProvider),
                  ),
                );
              },
            ),
            SizedBox(height: dimensions.height*0.03,width: double.infinity,),
            Text(
              userName ?? "Name",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'f'
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: dimensions.width*9,
              height: dimensions.height*0.05,
             // testing color: Colors.teal,
              child: Text(
                email ?? 'No email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey,
                  fontFamily: 'f',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(height: dimensions.height*0.05),
            GlowingButton(
              onPressed: () async {
                final Box<Reminder> reminderBox = Hive.box<Reminder>('reminderBox');
                try {
                  await FirebaseAuth.instance.signOut();
                  await reminderBox.clear();
                  await AwesomeNotifications().cancelAllSchedules();
                  Navigator.pushAndRemoveUntil<void>(
                    context,
                    MaterialPageRoute<void>(builder: (BuildContext context) =>  LoginScreen()),
                    ModalRoute.withName('/'),
                  );
                } catch (e) {
                  print('Error signing out: $e');
                  // Handle error if needed
                }
              },
              title: 'Logout',
              height: dimensions.height * 0.1,
              width: dimensions.width * 0.7,
            ),

          ],
        ),
      ),
    );
  }

  void _showUpdateProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose an option"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                  child: const ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text("Take a Photo"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                  child: const ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text("Choose from Gallery"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        // Dispatch event to ProfileBloc
        context.read<ProfileBloc>().add(TakeProfileImage(imageFile));
      }
    } catch (e) {
      // Handle image picking errors
      print('Error picking image: $e');
    }
  }
}
