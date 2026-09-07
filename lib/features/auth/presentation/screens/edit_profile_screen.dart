import 'package:crafty_bay/features/shared/presentation/widget/centered_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/widget/snack_bar_message.dart';
import '../../data/models/update_user_params.dart';
import '../providers/update_user_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const String name = '/edit_profile';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final UpdateUserProvider _updateUserProvider = UpdateUserProvider();

  void _updateProfile() async {
    UpdateUserParams params = UpdateUserParams(
      firstName: _firstNameTEController.text.trim(),
      lastName: _lastNameTEController.text.trim(),
      phone: _mobileTEController.text.trim(),
      city: _cityTEController.text.trim(),
    );

    bool result = await _updateUserProvider.updateUser(params);

    if(!mounted) return;

    if(result){
      showSnackBarMessage(context, "Profile Updated Successfully");
      Navigator.pop(context);
    }else{
      showSnackBarMessage(context, _updateUserProvider.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _updateUserProvider,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),
      
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                spacing: 8,
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: CircleAvatar(
                      radius: 40,
                      child: Icon(Icons.person, size: 48),
                    ),
                  ),
                  SizedBox(height: 16),
                    
                  TextFormField(
                    controller: _firstNameTEController,
                    textInputAction: .next,
                    decoration: InputDecoration(
                      hint: Text("First Name"),
                      suffixIcon: IconButton(
                        onPressed: () => _clearData(_firstNameTEController),
                        icon: Icon(Icons.cancel),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your first name';
                      }
                      return null;
                    }
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _lastNameTEController,
                    textInputAction: .next,
                    decoration: InputDecoration(
                      hint: Text("Last Name"),
                      suffixIcon: IconButton(
                        onPressed: () => _clearData(_lastNameTEController),
                        icon: Icon(Icons.cancel),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your last name';
                      }
                      return null;
                    }
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _mobileTEController,
                    textInputAction: .next,
                    keyboardType: .phone,
                    decoration: InputDecoration(
                      hint: Text("Mobile"),
                      suffixIcon: IconButton(
                        onPressed: () => _clearData(_mobileTEController),
                        icon: Icon(Icons.cancel),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your mobile number';
                      }else if(value.length != 11){
                        return 'Enter a valid mobile number';
                      }
                      return null;
                    }
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _cityTEController,
                    textInputAction: .next,
                    decoration: InputDecoration(
                      hint: Text("City"),
                      suffixIcon: IconButton(
                        onPressed: () => _clearData(_cityTEController),
                        icon: Icon(Icons.cancel),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your city';
                      }
                      return null;
                    }
                  ),
                    
                  SizedBox(height: 24,),
                    
                  Consumer<UpdateUserProvider>(
                    builder: (context, _, _) {
                      return FilledButton(
                        onPressed: _changeProfile,
                        child: _updateUserProvider.isUpdateInProgress? CenteredProgressIndicator() : Text("Update Profile"),
                      );
                    }
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _clearData(TextEditingController textEditingController) {
    textEditingController.clear();
  }

  void _changeProfile(){
    if(_formKey.currentState!.validate()){
      _updateProfile();
    }
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
    super.dispose();
  }
}
