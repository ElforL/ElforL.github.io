import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laith_shono/main.dart';
import 'package:laith_shono/widgets/socials_wrap.dart';

class ContactPage extends StatelessWidget {
  ContactPage({Key? key}) : super(key: key);

  final buttonsWidth = 250.0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      constraints: BoxConstraints(
        minHeight: height,
        minWidth: width,
      ),
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.contact_me,
            style: Theme.of(context).textTheme.headline2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: ContactForm()),
                if (width > 650) ...[
                  SizedBox(width: 50),
                  Flexible(
                    child: SvgPicture.asset(
                      'assets/undraw/undraw_letter.svg',
                      height: 450,
                    ),
                  ),
                ]
              ],
            ),
          ),
          if (width <= 650)
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: SvgPicture.asset(
                'assets/undraw/undraw_letter.svg',
                height: 200,
              ),
            ),
        ],
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();

  final _decoration = InputDecoration(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
    filled: true,
    alignLabelWithHint: true,
  );

  final double _tfsSpacing = 15;

  late final TextEditingController _emailController;
  late final TextEditingController _subjectController;
  late final TextEditingController _messageController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _subjectController = TextEditingController();
    _messageController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // EMAIL
          TextFormField(
            controller: _emailController,
            decoration: _decoration.copyWith(labelText: AppLocalizations.of(context)!.email_address),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.plz_enter_email;
              }
              // yeah it's not the best validation but it's a contact form, bad email won't break anything
              if (!value.contains('@')) return AppLocalizations.of(context)!.invalid_email;
              return null;
            },
          ),
          SizedBox(height: _tfsSpacing),

          // SUBJECT
          TextFormField(
            controller: _subjectController,
            decoration: _decoration.copyWith(labelText: AppLocalizations.of(context)!.subject),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.plz_enter_subject;
              }
              return null;
            },
          ),
          SizedBox(height: _tfsSpacing),

          // MESSAGE
          TextFormField(
            controller: _messageController,
            decoration: _decoration.copyWith(labelText: AppLocalizations.of(context)!.message),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.plz_enter_msg;
              }
              return null;
            },
            maxLines: null,
            minLines: 5,
          ),
          SizedBox(height: _tfsSpacing),

          //
          // SEND BUTTON

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: SocialsWrap()),
              OutlinedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30)),
                ),
                child: Text(
                  AppLocalizations.of(context)!.send.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  final isValid = _formKey.currentState?.validate() ?? false;
                  if (!isValid) return;

                  final email = _emailController.text.trim();
                  final subject = _subjectController.text.trim();
                  final message = _messageController.text.trim();

                  dbServices.sendMessage(email, subject, message);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
