import 'package:flutter/material.dart';
import 'package:taskyapp/core/constants/storage_key.dart';
import 'package:taskyapp/core/services/preferences_manager.dart';
import 'package:taskyapp/core/widgets/custom_text_form_field.dart';

class UserDetailsScreen extends StatefulWidget {
  UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController quoteController = TextEditingController();
  String? userName;
  String? quote;

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadQuote();
  }

  void _loadQuote() {
    setState(() {
      quote = PreferencesManager().getString('quote') ?? 'One task at a time.One step closer.';
    });
  }

  void _loadUserName() async {
    final userNameValue =
        await PreferencesManager().getString(StorageKey.username) ?? '';
    setState(() {
      userName = userNameValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Details')),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _key,
          child: Column(
            children: [
              CustomTextFormField(
                controller: userNameController,
                hintText: '$userName',
                title: 'User Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter User Name  ";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: quoteController,
                hintText: '$quote',
                title: 'Motivation Quote',
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Motivation Quote";
                  }
                  return null;
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    await PreferencesManager().setString(
                      'username',
                      userNameController.value.text,
                    );
                    await PreferencesManager().setString(
                      'quote',
                      quoteController.value.text,
                    );

                    setState(() {
                      userName = userNameController.value.text;
                      quote = quoteController.value.text;
                    });

                    Navigator.pop(context, true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
