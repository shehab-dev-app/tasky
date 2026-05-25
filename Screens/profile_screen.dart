import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taskyapp/Screens/user_details_screen.dart';
import 'package:taskyapp/Screens/welcome_screen.dart';
import 'package:taskyapp/core/services/preferences_manager.dart';
import 'package:taskyapp/core/theme/theme_controller.dart';
import 'package:taskyapp/core/widgets/custom_svg_picture.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userName;
  String? quote;
  String? userImagePath;
  bool isDarkMode = true;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadQuote();
    _loadThemeMode();
    _loadUserImage();
  }

  void _loadQuote() async {
    setState(() {
      quote = PreferencesManager().getString('quote');
    });
  }

  void _loadUserName() async {
    setState(() {
      userName = PreferencesManager().getString('username');
    });
  }

  void _loadThemeMode() async {
    setState(() {
      isDarkMode = PreferencesManager().getBool('theme') ?? true;
    });
  }

  void _loadUserImage() async {
    setState(() {
      userImagePath = PreferencesManager().getString('user_image');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: userImagePath == null
                        ? AssetImage('assets/images/Thumbnail.png')
                        : FileImage(File(userImagePath!)),
                    backgroundColor: Colors.transparent,
                    radius: 60,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () async {
                        showImageSourceDialog(context, (XFile file) {
                          _saveImage(file);
                          setState(() {
                            userImagePath = file.path;
                          });
                        });
                      },
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        child: Icon(Icons.camera_alt),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text('$userName', style: Theme.of(context).textTheme.labelSmall),
              Text(
                quote ?? 'One task at a time.One step closer.',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Profile Info',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
              SizedBox(height: 24),

              ListTile(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return UserDetailsScreen();
                      },
                    ),
                  );
                  if (result != null && result) {
                    _loadUserName();
                    _loadQuote();
                  }
                },
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'User Details',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                leading: CustomSvgPicture(
                  path: 'assets/images/profile_icon.svg',
                ),
                trailing: CustomSvgPicture(path: 'assets/images/arrow.svg'),
              ),
              Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Dark Mode',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                leading: CustomSvgPicture(path: 'assets/images/darkMode.svg'),

                trailing: ValueListenableBuilder(
                  valueListenable: ThemeController.themeNotifier,
                  builder: (BuildContext context, value, Widget? child) {
                    return Switch(
                      value: value == ThemeMode.dark,
                      onChanged: (bool value) async {
                        ThemeController.toggleTheme();
                      },
                    );
                  },
                ),
              ),

              Divider(),
              ListTile(
                onTap: () async {
                  ///TODO : logOut
                  PreferencesManager().remove('username');
                  PreferencesManager().remove('quote');
                  PreferencesManager().remove('tasks');

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return WelcomeScreen();
                      },
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Log Out',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                leading: CustomSvgPicture(path: 'assets/images/logOut.svg'),
                trailing: CustomSvgPicture(path: 'assets/images/arrow.svg'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showImageSourceDialog(
    BuildContext context,
    Function(XFile) selectedFile,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            'choose Image Source',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(16),
              onPressed: () async {
                Navigator.pop(context);

                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                print("Camera result: $image");
                if (image != null) {
                  selectedFile(image);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 8),
                  Text('Camera'),
                ],
              ),
            ),

            SimpleDialogOption(
              padding: EdgeInsets.all(16),
              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  selectedFile(image);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.photo_library),
                  SizedBox(width: 8),
                  Text('gallery'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _saveImage(XFile file) async {
    final appDir = await getApplicationCacheDirectory();
    final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
    PreferencesManager().setString('user_image', newFile.path);
  }
}
