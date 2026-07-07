import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFF2C4C3B);
    const textPrimary = Color(0xFFE8D8A7);
    const textSecondary = Color(0xFF8B8A87);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Settings',
          style: GoogleFonts.inter(
            fontSize: 16,
            color: textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          _buildSettingsGroup(
            'ACCOUNT',
            [
              _buildSettingItem('Personal Information'),
              _buildSettingItem('Payment Methods'),
              _buildSettingItem('Delivery Addresses'),
            ],
          ),
          const SizedBox(height: 32),
          _buildSettingsGroup(
            'PREFERENCES',
            [
              _buildSettingItem('Language', trailingText: 'English'),
              _buildSettingItem('Notifications'),
              _buildSettingItem('Appearance', trailingText: 'Dark'),
              _buildSettingItem('Accessibility'),
            ],
          ),
          const SizedBox(height: 32),
          _buildSettingsGroup(
            'SECURITY & PRIVACY',
            [
              _buildSettingItem('Security'),
              _buildSettingItem('Privacy Policy'),
              _buildSettingItem('Terms of Service'),
            ],
          ),
          const SizedBox(height: 48),
          Center(
            child: Text(
              'MISO App Version 1.0.0',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF8B8A87),
              letterSpacing: 1.0,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF161616),
            border: Border(
              top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
              bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
            ),
          ),
          child: Column(
            children: [
              for (int i = 0; i < items.length; i++) ...[
                items[i],
                if (i < items.length - 1)
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Divider(
                      height: 1,
                      color: Colors.white.withValues(alpha: 0.05),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(String title, {String? trailingText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: const Color(0xFFE8D8A7),
            ),
          ),
          Row(
            children: [
              if (trailingText != null) ...[
                Text(
                  trailingText,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: const Color(0xFF8B8A87),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF8B8A87),
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
