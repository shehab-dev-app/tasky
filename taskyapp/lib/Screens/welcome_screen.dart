import 'package:flutter/material.dart';
import 'package:taskyapp/core/constants/storage_key.dart';
import 'package:taskyapp/features/navigation/main_screen.dart';
import 'package:taskyapp/core/services/preferences_manager.dart';
import 'package:taskyapp/core/widgets/custom_svg_picture.dart';
import 'package:taskyapp/core/widgets/custom_text_form_field.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSvgPicture.withOutColorFilter(
                        path: 'assets/images/Vector.svg',
                        width: 42,
                        height: 42,
                      ),

                      SizedBox(width: 16),
                      Text(
                        "Tasky",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 118),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome To Tasky ",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      CustomSvgPicture.withOutColorFilter(
                        path: 'assets/images/waving-hand.svg',
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Your productivity journey starts here. ",
                    style: Theme.of(
                      context,
                    ).textTheme.displaySmall!.copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  CustomSvgPicture.withOutColorFilter(
                    path: 'assets/images/pana.svg',
                    width: 200,
                    height: 200,
                  ),

                  SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),

                    child: CustomTextFormField(
                      icon: IconButton(
                        onPressed: () {
                          controller.clear();
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                      ),
                      controller: controller,
                      hintText: 'e.g. Sarah Khalid',
                      title: 'Full Name',
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_key.currentState?.validate() ?? false) {
                          await PreferencesManager().setString(
                            StorageKey.username,
                            controller.value.text,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return MainScreen();
                              },
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('please enter your name')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF15B86C),
                        foregroundColor: const Color(0XFFFFFCFC),
                        fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      ),
                      child: Text(
                        "Let’s Get Started",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
