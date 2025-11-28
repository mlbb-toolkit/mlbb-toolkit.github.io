import 'package:flutter/material.dart';
import 'main.dart'; // for FadeSlide

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  final ScrollController _scroll = ScrollController();
  double _offset = 0.0;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      setState(() => _offset = _scroll.offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mobile = MediaQuery.of(context).size.width < 650;
    final dark = theme.brightness == Brightness.dark;

    final parallax = _offset * 0.12;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: _offset > 10 ? 1 : 0,
        backgroundColor: theme.scaffoldBackgroundColor
            .withValues(alpha: _offset > 10 ? 0.95 : 0.2),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text("Privacy Policy"),
      ),

      body: Stack(
        children: [
          // Background
          AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: dark
                    ? const [
                  Color(0xFF020617),
                  Color(0xFF0F172A),
                  Color(0xFF111827),
                ]
                    : const [
                  Color(0xFFE0EAFF),
                  Color(0xFFF5F3FF),
                  Color(0xFFF9FAFB),
                ],
              ),
            ),
          ),

          // Blobs
          Positioned(
            top: -120 + parallax,
            left: -80,
            child: _blob(
              size: 260,
              color:
              theme.colorScheme.primary.withValues(alpha: dark ? 0.20 : 0.25),
            ),
          ),
          Positioned(
            top: 260 - parallax,
            right: -60,
            child: _blob(
              size: 220,
              color: theme.colorScheme.secondary
                  .withValues(alpha: dark ? 0.16 : 0.22),
            ),
          ),

          // MAIN CONTENT – LEFT ALIGNED FULL WIDTH
          SingleChildScrollView(
            controller: _scroll,
            padding: EdgeInsets.symmetric(
              horizontal: mobile ? 20 : 60,
              vertical: 120,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerBlock(theme),
                const SizedBox(height: 40),

                _card(theme, "1. No Affiliation With Moonton", """
ML Toolkit is an independent tool and is not affiliated with Moonton or Mobile Legends: Bang Bang.
All assets belong to Moonton Games.
"""),

                _card(theme, "2. Information We Collect", """
We only collect minimal, non-identifiable data needed for app functionality.
"""),

                _card(theme, "2.1 Automatically Collected (Non-Identifiable)", """
• Device model & OS version
• Crash logs
• Basic performance analytics

We do NOT collect:
• IP address
• Location
• Personal identity data
"""),

                _card(theme, "2.2 User-Provided Data", """
We do NOT collect identity data.

Only stored optionally:
• In-app points
• Cosmetic import logs

Not stored:
• Names
• Referral codes
• MLBB login data
"""),

                _card(theme, "3. Permissions We Use", ""),

                _card(theme, "3.1 Storage Access", """
Used only for user-selected cosmetic imports.
"""),

                _card(theme, "3.2 Internet Access", """
Used only for:
• Cosmetic updates
• Reward system
• Anonymous analytics
• Backend communication
"""),

                _card(theme, "4. How We Use Information", """
• Operate app features
• Track reward points
• Improve stability
• Prevent abuse

No ads, no tracking, no profiling.
"""),

                _card(theme, "5. Third-Party Providers", ""),

                _card(theme, "5.1 Supabase (Anonymous)", """
Used for reward logs and points.
No tokens, no login — anonymous only.
"""),

                _card(theme, "5.2 Analytics", """
Anonymous usage analytics only (if enabled).
"""),

                _card(theme, "6. Data Sharing", """
We NEVER sell user data.

Shared only with:
• Supabase
• Analytics platforms
• Legal authorities if required
"""),

                _card(theme, "7. Data Retention", """
• Rewards: up to 12 months
• Analytics: ~24 months
• Import logs: temporary
"""),

                _card(theme, "8. Children’s Privacy", """
Not intended for children under age 13.
"""),

                _card(theme, "9. Cosmetic-Only Disclaimer", """
ML Toolkit only provides visual cosmetic customization.
It does NOT modify gameplay or give competitive advantages.
"""),

                _card(theme, "10. Anti-Cheat & Fair Play Policy", """
Strictly prohibited:
• Map hacks
• Drone views
• Radar hacks
• Cooldown cheats
• Damage/defense mods
• Any gameplay-altering methods
"""),

                _card(theme, "11. Security Practices", """
All communication uses HTTPS.
Users remain fully anonymous.
"""),

                _card(theme, "12. DMCA & Copyright", """
All MLBB assets belong to Moonton Games.
DMCA requests are honored immediately.
"""),

                _card(theme, "13. Changes to This Policy", """
This policy may be updated as needed.
"""),

                _card(theme, "14. Contact Us", """
📩 Email: devcloper.url@gmail.com
🌐 Website: https://mlbb-toolkit.github.io
"""),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // HEADER CARD — LEFT ALIGNED
  Widget _headerBlock(ThemeData theme) {
    return FadeSlide(
      offset: 20,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 32),
        decoration: BoxDecoration(
          color: theme.cardColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: 0.14),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Privacy Policy",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 12),
            Text(
              "Learn how ML Toolkit handles privacy, security, and data protection.",
              style: TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }

  // SECTION CARDS — LEFT ALIGNED FULL WIDTH
  Widget _card(ThemeData theme, String title, String body) {
    return FadeSlide(
      offset: 22,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 32),
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 32),
        decoration: BoxDecoration(
          color: theme.cardColor.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: 0.14),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.start,
            ),
            if (body.trim().isNotEmpty) ...[
              const SizedBox(height: 18),
              Text(
                body,
                style: const TextStyle(height: 1.55, fontSize: 15.5),
                textAlign: TextAlign.start,
              ),
            ],
          ],
        ),
      ),
    );
  }

  // BLOBS
  Widget _blob({required double size, required Color color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
