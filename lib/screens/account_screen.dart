import 'dart:io';
import 'package:bookmytime/models/announcement.dart';
import 'package:bookmytime/pages/theme_selection_page.dart';
import 'package:bookmytime/screens/logIn_screen.dart';
import 'package:bookmytime/screens/userAnnouncement_screen.dart';
import 'package:bookmytime/services/auth_services.dart';
import 'package:bookmytime/services/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authService = AuthServices();
  late File _image;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  Map<String, dynamic> userInfos = {};

  Future<void> getUsersInfo() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('uid', isEqualTo: _firebaseAuth.currentUser!.uid)
        .get();

    var user = querySnapshot.docs.first.data() as Map<String, dynamic>;

    setState(() {
      userInfos = user;
    });
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<List<Announcement>> _getUserAnnouncements() async {
    final userUid = FirebaseAuth.instance.currentUser?.uid;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('announcements')
        .where('userId', isEqualTo: userUid)
        .get();
    final List<Announcement> userAnnouncements = [];
    querySnapshot.docs.forEach((doc) {
      final announcement = Announcement.fromSnapshot(doc);
      userAnnouncements.add(announcement);
    });
    return userAnnouncements;
  }

  @override
  void initState() {
    super.initState();
    _image = File(
        'assets/images/blank_profile.jpg'); // Initialize with default image path
    getUsersInfo();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Account'),
      ),
      body: Container(
        color: themeProvider.currentTheme.primaryColor,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: _image != null ? FileImage(_image) : null,
              child: _image == null
                  ? const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    )
                  : null,
            ),
            const SizedBox(height: 20),
            
            Text(
              '${userInfos['username']}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Email',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              '${userInfos['email']}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final userAnnouncements = await _getUserAnnouncements();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const UserAnnouncementScreen(), // Navigate to AllAnnouncementsScreen
                  ),
                );
              },
              child: Text('My Announcements'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImage,
              child: const Text('Choose Profile Photo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThemeSelectionPage(),
                  ),
                );
              },
              child: const Text('Choose Theme'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await authService.SignOut();
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LogInScreen(),
                  ),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
