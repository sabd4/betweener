import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';
import 'package:tt9_betweener_challenge/views/widgets/secondary_button_widget.dart';

import '../constants.dart';
import '../controllers/add_link_controller.dart';
import 'main_app_view.dart';

class NewLinkView extends StatefulWidget {
  static const id = '/newLinkView';

  const NewLinkView({Key? key}) : super(key: key);

  @override
  State<NewLinkView> createState() => _NewLinkViewState();
}

class _NewLinkViewState extends State<NewLinkView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void submitLink() {
    if (_formKey.currentState!.validate()) {
      final body = {'title': titleController.text, 'link': linkController.text};

      addLink(body).then((user) async {
        if (mounted) {
          Navigator.pushNamed(context, MainAppView.id);
        }
      }).catchError((err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err.toString()),
          backgroundColor: Colors.red,
        ));
      });

      Navigator.pushNamed(context, MainAppView.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Link'),
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
                    controller: titleController,
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
                    controller: linkController,
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
                  SecondaryButtonWidget(onTap: submitLink, text: 'ADD'),
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
