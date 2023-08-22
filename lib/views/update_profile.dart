import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';
import 'package:tt9_betweener_challenge/views/widgets/secondary_button_widget.dart';

import '../constants.dart';
import '../controllers/add_link_controller.dart';
import '../controllers/update_link_controller.dart';
import 'main_app_view.dart';

class UpdateProfileView extends StatefulWidget {
  static const id = '/updateProfileView';
  final int? userId;
  final String name;
  final String email;

  const UpdateProfileView({
    Key? key,
    this.userId,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  TextEditingController updateTitleController = TextEditingController();
  TextEditingController updateLinkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int? linkId;
  @override
  void editLink() {
    if (_formKey.currentState!.validate()) {
      final body = {
        'name': updateTitleController.text,
        'email': updateLinkController.text
      };
      // int? linkId = widget.linkId; // Access linkId from the constructor

      // if (linkId != null) {
      //   print('update:$linkId');
      //   // Perform a null check before using linkId
      //   updateLink(body, linkId).then((user) {
      //     if (mounted) {
      //       Navigator.pushNamed(context, MainAppView.id);
      //     }
      //   }).catchError((err) {
      //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //       content: Text(err.toString()),
      //       backgroundColor: Colors.red,
      //     ));
      //   });
      // }
    }
  }

  void initState() {
    super.initState();
    // linkId = widget.linkId;
    print('update:$linkId');
    updateTitleController.text = widget.name;
    updateLinkController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User Info'),
        backgroundColor: kLightPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/imgs/img.png'),
                    radius: 100,
                  ),
                  CustomTextFormField(
                    controller: updateTitleController,
                    hint: 'name',
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    label: 'name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter the email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomTextFormField(
                    controller: updateLinkController,
                    hint: 'email.com',
                    label: 'email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter the email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SecondaryButtonWidget(onTap: editLink, text: 'SAVE'),
                  const SizedBox(
                    height: 24,
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
