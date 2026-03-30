// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl  = TextEditingController();
  final _emailCtrl     = TextEditingController();
  final _subjectCtrl   = TextEditingController();
  final _messageCtrl   = TextEditingController();

  bool _loading = false;

  // ── Palette ───────────────────────────────────────────────
  static const kBlue      = Color(0xFF2563EB);
  // ignore: unused_field
  static const kBlueBg    = Color(0xFFEFF6FF);
  static const kBluePill  = Color(0xFFDBEAFE);
  static const kBlueBdr   = Color(0xFF93C5FD);
  static const kText      = Color(0xFF111827);
  static const kSubtext   = Color(0xFF4B5563);
  static const kBorder    = Color(0xFFD1D9F0);
  static const kFieldBg   = Color(0xFFF5F8FF);
  static const kSuccess   = Color(0xFF16A34A);
  static const kSuccessBg = Color(0xFFDCFCE7);
  static const kSuccessBd = Color(0xFF86EFAC);

  // ── Contact details ───────────────────────────────────────
  static const _email  = 'isaac@snapp.co.ke';
  static const _phone  = '0797419279';
  // Matrix One, General Mathenge Drive, Westlands, Nairobi
  static const _mapLat = '-1.2634';
  static const _mapLng = '36.7889';

  @override
  void dispose() {
    _firstNameCtrl.dispose(); _lastNameCtrl.dispose();
    _emailCtrl.dispose(); _subjectCtrl.dispose(); _messageCtrl.dispose();
    super.dispose();
  }

  // ── URL launchers ─────────────────────────────────────────

  Future<void> _launchEmail() async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: _email,
      queryParameters: {'subject': 'Hello from the app'},
    );
    if (!await launchUrl(uri)) {
      _showSnack('Could not open email app.', isError: true);
    }
  }

  Future<void> _launchPhone() async {
    final Uri uri = Uri(scheme: 'tel', path: _phone);
    if (!await launchUrl(uri)) {
      _showSnack('Could not open dialer.', isError: true);
    }
  }

  Future<void> _launchMap() async {
    // geo: URI — drops a named pin on Android native maps apps in English
    final Uri geoUri = Uri.parse(
      'geo:$_mapLat,$_mapLng?q=$_mapLat,$_mapLng(Matrix+One+General+Mathenge+Westlands)',
    );

    // Browser fallback — hl=en forces English, z=18 zooms to building level
    final Uri browserUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1'
      '&query=$_mapLat,$_mapLng'
      '&query_place_id=ChIJt3JxcMIVLxgRExGRMBTGpBs'
      '&hl=en'
      '&z=18',
    );

    if (await canLaunchUrl(geoUri)) {
      await launchUrl(geoUri, mode: LaunchMode.externalApplication);
    } else if (await canLaunchUrl(browserUri)) {
      await launchUrl(browserUri, mode: LaunchMode.externalApplication);
    } else {
      _showSnack('Could not open maps.', isError: true);
    }
  }

  // ── Firestore submit ──────────────────────────────────────

  Future<void> _sendMessage() async {
    final firstName = _firstNameCtrl.text.trim();
    final lastName  = _lastNameCtrl.text.trim();
    final email     = _emailCtrl.text.trim();
    final subject   = _subjectCtrl.text.trim();
    final message   = _messageCtrl.text.trim();

    if (firstName.isEmpty || email.isEmpty || message.isEmpty) {
      _showSnack('Please fill in First Name, Email and Message.', isError: true);
      return;
    }
    if (!email.contains('@')) {
      _showSnack('Please enter a valid email address.', isError: true);
      return;
    }

    setState(() => _loading = true);

    try {
      await FirebaseFirestore.instance.collection('contact_messages').add({
        'firstName': firstName,
        'lastName':  lastName,
        'email':     email,
        'subject':   subject,
        'message':   message,
        'timestamp': FieldValue.serverTimestamp(),
        'status':    'unread',
      });

      _firstNameCtrl.clear(); _lastNameCtrl.clear();
      _emailCtrl.clear(); _subjectCtrl.clear(); _messageCtrl.clear();

      _showSuccessDialog();
    } catch (e) {
      _showSnack('Failed to send message. Please try again.', isError: true);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(36),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72, height: 72,
                decoration: BoxDecoration(
                  color: kSuccessBg,
                  shape: BoxShape.circle,
                  border: Border.all(color: kSuccessBd, width: 2),
                ),
                child: const Icon(Icons.check_rounded, color: kSuccess, size: 38),
              ),
              const SizedBox(height: 20),
              const Text('Message Sent!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: kText)),
              const SizedBox(height: 10),
              const Text(
                'Thank you for reaching out.\nWe\'ll get back to you as soon as possible.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: kSubtext, height: 1.6),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity, height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text('Done',
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w700, fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnack(String msg, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: isError ? Colors.red.shade600 : kSuccess,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(16),
    ));
  }

  // ════════════════════════════════════════════════════════════
  // BUILD
  // ════════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 96),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEFF6FF), Color(0xFFF0F9FF), Color(0xFFEEF2FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1024),
          child: Column(
            children: [
              // Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: kBluePill,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: kBlueBdr, width: 1),
                ),
                child: const Text('Contact Us',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,
                      color: Color(0xFF1D4ED8))),
              ),
              const SizedBox(height: 24),

              const Text('Get in touch',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: kText)),
              const SizedBox(height: 24),

              const Text(
                'Have questions? We\'d love to hear from you. Send us a message and we\'ll respond as soon as possible.',
                style: TextStyle(fontSize: 20, color: kSubtext),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 64),

              // Form card
              Container(
                padding: const EdgeInsets.all(48),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE0EAFF), width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: kBlue.withOpacity(0.08),
                      blurRadius: 40,
                      offset: const Offset(0, 16),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildTextField('First Name', 'John', _firstNameCtrl)),
                        const SizedBox(width: 24),
                        Expanded(child: _buildTextField('Last Name', 'Doe', _lastNameCtrl)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildTextField('Email Address', 'john.doe@example.com', _emailCtrl,
                        keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 24),
                    _buildTextField('Subject', 'How can we help?', _subjectCtrl),
                    const SizedBox(height: 24),
                    _buildTextField('Message', 'Tell us more about your inquiry...',
                        _messageCtrl, maxLines: 6),
                    const SizedBox(height: 32),

                    // Send button
                    SizedBox(
                      width: double.infinity, height: 52,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _sendMessage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kBlue,
                          disabledBackgroundColor: kBlue.withOpacity(0.4),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          elevation: 0,
                        ),
                        child: _loading
                            ? const SizedBox(width: 22, height: 22,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2.5, color: Colors.white))
                            : const Text('Send Message',
                                style: TextStyle(fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                      ),
                    ),

                    const SizedBox(height: 48),
                    Divider(color: const Color(0xFFE0EAFF), thickness: 1.2),
                    const SizedBox(height: 48),

                    // ── Tappable contact info ──────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildContactInfo(
                          icon: Icons.email_outlined,
                          title: 'Email',
                          value: _email,
                          onTap: _launchEmail,
                        ),
                        _buildContactInfo(
                          icon: Icons.phone_outlined,
                          title: 'Phone',
                          value: '0797 419 279',
                          onTap: _launchPhone,
                        ),
                        _buildContactInfo(
                          icon: Icons.location_on_outlined,
                          title: 'Office',
                          value: 'Matrix One\nGeneral Mathenge, 9th Floor',
                          onTap: _launchMap,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: kText)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(color: kText, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
            filled: true,
            fillColor: kFieldBg,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kBlue, width: 2),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Column(
          children: [
            Container(
              width: 52, height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFDBEAFE),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: kBlue, size: 24),
            ),
            const SizedBox(height: 14),
            Text(title,
              style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w700, color: kText)),
            const SizedBox(height: 4),
            Text(value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: kBlue,
                decoration: TextDecoration.underline,
                decorationColor: kBlue,
                height: 1.5,
              )),
          ],
        ),
      ),
    );
  }
}