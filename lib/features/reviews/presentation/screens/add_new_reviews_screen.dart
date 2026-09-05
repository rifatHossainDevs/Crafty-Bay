import 'package:crafty_bay/features/reviews/presentation/data/models/add_review_params.dart';
import 'package:crafty_bay/features/shared/presentation/widget/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/add_review_provider.dart';

class AddNewReviewsScreen extends StatefulWidget {
  const AddNewReviewsScreen({super.key, required this.productId});

  static const String name = '/add-new-reviews-screen';
  final String productId;

  @override
  State<AddNewReviewsScreen> createState() => _AddNewReviewsScreenState();
}

class _AddNewReviewsScreenState extends State<AddNewReviewsScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _reviewTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AddReviewProvider _addReviewProvider = AddReviewProvider();

  Future<void> _addReview() async {
    bool result = await _addReviewProvider.addReview(
      AddReviewParams(
        productId: widget.productId,
        comment: _reviewTEController.text.trim(),
        rating: "4.5",
      ),
    );

    if(result){
      showSnackBarMessage(context, "Review added successfully");
      Navigator.pop(context);
    }else{
      showSnackBarMessage(context, _addReviewProvider.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _addReviewProvider,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create Reviews"),
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
            child: Column(
              children: [
                TextFormField(
                  controller: _firstNameTEController,
                  keyboardType: .emailAddress,
                  textInputAction: .next,
                  decoration: InputDecoration(
                    hint: Text(
                      "First Name",
                      style: TextStyle(color: Colors.grey),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => _clearData(_firstNameTEController),
                      icon: Icon(Icons.cancel, color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your first name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _lastNameTEController,
                  keyboardType: .emailAddress,
                  textInputAction: .next,
                  decoration: InputDecoration(
                    hint: Text("Last Name", style: TextStyle(color: Colors.grey)),
                    suffixIcon: IconButton(
                      onPressed: () => _clearData(_lastNameTEController),
                      icon: Icon(Icons.cancel, color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your last name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _reviewTEController,
                  keyboardType: .emailAddress,
                  textInputAction: .next,
                  minLines: 10,
                  maxLines: 16,
                  decoration: InputDecoration(
                    hint: Text(
                      "Write Review",
                      style: TextStyle(color: Colors.grey),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => _clearData(_reviewTEController),
                      icon: Icon(Icons.cancel, color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your review";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 24),

                FilledButton(onPressed: () {
                  if(_formKey.currentState!.validate()){
                    _addReview();
                  }
                }, child: Text("Submit")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _clearData(TextEditingController textEditingController) {
    textEditingController.clear();
  }
}
