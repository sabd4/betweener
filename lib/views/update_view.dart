import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:tt9_betweener_challenge/views/profile_view.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';
import 'package:tt9_betweener_challenge/views/widgets/secondary_button_widget.dart';

import '../constants.dart';
import '../controllers/add_link_controller.dart';
import '../controllers/update_link_controller.dart';
import 'main_app_view.dart';

class UpdateLinkView extends StatefulWidget {
  static const id = '/updateLinkView';
  final int? linkId;
  final String title;
  final String link;

  const UpdateLinkView(
      {Key? key, this.linkId, required this.title, required this.link})
      : super(key: key);

  @override
  State<UpdateLinkView> createState() => _UpdateLinkViewState();
}

class _UpdateLinkViewState extends State<UpdateLinkView> {
  TextEditingController updateTitleController = TextEditingController();
  TextEditingController updateLinkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int? id;
  @override
  void editLink() {
    if (_formKey.currentState!.validate()) {
      final body = {
        'title': updateTitleController.text,
        'link': updateLinkController.text
      };

      if (id != null) {
        updateLink(body, id!).then((user) {
          setState(() {});
          if (mounted) {
            Navigator.pushNamed(context, MainAppView.id);
          }
        }).catchError((err) {
          print(err);
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text(err.toString()),
          //     backgroundColor: Colors.red,
          //   ),
          // );
        });
      }
      Phoenix.rebirth(context);
    }
  }

  @override
  void initState() {
    super.initState();
    id = widget.linkId;
    print('update:$id');
    updateTitleController.text = widget.title;
    updateLinkController.text = widget.link;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Link'),
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
                  CustomTextFormField(
                    controller: updateTitleController,
                    hint: 'snapchat',
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    label: 'title',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter the title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomTextFormField(
                    controller: updateLinkController,
                    hint: 'http:\\snapchat.com',
                    label: 'link',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter the link';
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
