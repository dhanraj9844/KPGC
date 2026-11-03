import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../constants/app_constants.dart';
import '../utils/url_helper.dart';
import 'primary_button.dart';

/// Reusable enquiry / contact / site-visit form.
///
/// No backend is configured, so "Send" opens WhatsApp with the details
/// pre-filled. Nothing is stored by this website and success is never faked.
/// To use a real backend, replace [_submit] (see README).
class EnquiryForm extends StatefulWidget {
  const EnquiryForm({
    super.key,
    this.dark = false,
    this.initialType = 'General Enquiry',
    this.initialProject = 'Royal Woods',
  });

  final bool dark;
  final String initialType;
  final String initialProject;

  @override
  State<EnquiryForm> createState() => _EnquiryFormState();
}

class _EnquiryFormState extends State<EnquiryForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _mobile = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();
  late String _type = widget.initialType;
  late String _project = widget.initialProject;
  String? _time;
  bool _sending = false;
  String? _notice;

  @override
  void dispose() {
    _name.dispose();
    _mobile.dispose();
    _email.dispose();
    _message.dispose();
    super.dispose();
  }

  Color get _text => widget.dark ? AppColors.white : AppColors.charcoal;
  Color get _hint => widget.dark ? Colors.white70 : AppColors.secondaryText;
  Color get _line => widget.dark ? Colors.white30 : const Color(0xFFBDBAB2);

  InputDecoration _dec(String label) => InputDecoration(
        labelText: label,
        labelStyle: AppText.body(size: 13, color: _hint),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: _line)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.gold, width: 1.6)),
        errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE57373))),
        focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE57373), width: 1.6)),
        errorStyle: AppText.body(size: 12, color: const Color(0xFFE57373), height: 1.3),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      );

  String? _validateName(String? v) =>
      (v == null || v.trim().length < 2) ? 'Please enter your full name' : null;

  String _digits(String v) {
    var d = v.replaceAll(RegExp(r'\D'), '');
    if (d.length == 12 && d.startsWith('91')) d = d.substring(2);
    return d;
  }

  String? _validateMobile(String? v) =>
      RegExp(r'^[6-9]\d{9}$').hasMatch(_digits(v ?? '')) ? null : 'Enter a valid 10-digit mobile number';

  String? _validateEmail(String? v) {
    final t = (v ?? '').trim();
    if (t.isEmpty) return null; // optional
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(t) ? null : 'Enter a valid email address';
  }

  String _buildMessage() {
    final b = StringBuffer('Hello KPGC Ventures,\n')
      ..writeln('Name: ${_name.text.trim()}')
      ..writeln('Mobile: ${_digits(_mobile.text)}');
    if (_email.text.trim().isNotEmpty) b.writeln('Email: ${_email.text.trim()}');
    b
      ..writeln('Project: $_project')
      ..writeln('Enquiry type: $_type');
    if (_time != null) b.writeln('Preferred contact time: $_time');
    if (_message.text.trim().isNotEmpty) b.writeln('Message: ${_message.text.trim()}');
    return b.toString();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _sending = true;
      _notice = null;
    });
    await UrlHelper.whatsapp(context, message: _buildMessage());
    if (!mounted) return;
    setState(() {
      _sending = false;
      _notice = 'WhatsApp has opened with your details. Please press Send there to deliver your enquiry to our team.';
    });
  }

  Widget _pair(Widget a, Widget b) => LayoutBuilder(builder: (context, c) {
        if (c.maxWidth < 520) return Column(children: [a, b]);
        return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: a),
          const SizedBox(width: 24),
          Expanded(child: b),
        ]);
      });

  Widget _drop(String label, String? value, List<String> items, ValueChanged<String?> onChanged) =>
      DropdownButtonFormField<String>(
        initialValue: value,
        isExpanded: true,
        decoration: _dec(label),
        dropdownColor: widget.dark ? AppColors.forest : AppColors.white,
        iconEnabledColor: _hint,
        style: AppText.body(size: 14, color: _text),
        items: [for (final i in items) DropdownMenuItem(value: i, child: Text(i))],
        onChanged: onChanged,
      );

  @override
  Widget build(BuildContext context) {
    final style = AppText.body(size: 14, color: _text);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _pair(
            TextFormField(controller: _name, style: style, cursorColor: AppColors.gold, decoration: _dec('Full Name'), validator: _validateName, textInputAction: TextInputAction.next, autofillHints: const [AutofillHints.name]),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: TextFormField(controller: _mobile, style: style, cursorColor: AppColors.gold, decoration: _dec('Mobile Number'), validator: _validateMobile, keyboardType: TextInputType.phone, textInputAction: TextInputAction.next, autofillHints: const [AutofillHints.telephoneNumber]),
            ),
          ),
          TextFormField(controller: _email, style: style, cursorColor: AppColors.gold, decoration: _dec('Email Address (optional)'), validator: _validateEmail, keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next),
          _pair(
            _drop('Interested Project', _project, const ['Royal Woods', 'Other / Not sure'], (v) => setState(() => _project = v ?? _project)),
            _drop('Enquiry Type', _type, AppConstants.enquiryTypes, (v) => setState(() => _type = v ?? _type)),
          ),
          _drop('Preferred Contact Time (optional)', _time, AppConstants.contactTimes, (v) => setState(() => _time = v)),
          TextFormField(controller: _message, style: style, cursorColor: AppColors.gold, decoration: _dec('Message'), maxLines: 3, minLines: 2),
          const SizedBox(height: 28),
          Align(
            alignment: Alignment.centerLeft,
            child: PrimaryButton(
              label: _sending ? 'Opening WhatsApp…' : 'Send Enquiry via WhatsApp',
              onPressed: _sending ? null : _submit,
              onDark: widget.dark,
            ),
          ),
          const SizedBox(height: 14),
          if (_notice != null)
            Text(_notice!, style: AppText.body(size: 13, color: AppColors.gold, height: 1.5)),
          Text(
            'This website does not store enquiries. Sending opens WhatsApp with your details pre-filled.',
            style: AppText.body(size: 11.5, color: _hint, height: 1.5),
          ),
        ],
      ),
    );
  }
}
