import 'package:flutter/material.dart';
import 'main.dart'; // for FadeSlide

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  final ScrollController _scroll = ScrollController();
  double _offset = 0;

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
    final dark = theme.brightness == Brightness.dark;
    final mobile = MediaQuery.of(context).size.width < 650;

    final parallax = _offset * 0.12;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: _offset > 10 ? 1 : 0,
        backgroundColor:
        theme.scaffoldBackgroundColor.withValues(alpha: _offset > 10 ? 0.95 : 0.2),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text("Terms of Service"),
      ),

      body: Stack(
        children: [
          // Background gradient
          AnimatedContainer(
            duration: const Duration(milliseconds: 700),
            decoration: BoxDecoration(
              gradient: LinearGradient(
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
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Accent blobs
          Positioned(
            top: -140 + parallax,
            left: -80,
            child: _blob(
              size: 260,
              color: theme.colorScheme.primary.withValues(alpha: dark ? 0.20 : 0.25),
            ),
          ),
          Positioned(
            top: 240 - parallax,
            right: -60,
            child: _blob(
              size: 220,
              color: theme.colorScheme.secondary.withValues(alpha: dark ? 0.15 : 0.22),
            ),
          ),

          // MAIN CONTENT
          SingleChildScrollView(
            controller: _scroll,
            padding: EdgeInsets.symmetric(
              horizontal: mobile ? 22 : 60,
              vertical: 120,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerBlock(theme),
                const SizedBox(height: 40),

                _card(theme, "Last Updated", """
January 2025

These Terms govern your use of ML Toolkit (“the App”). By downloading, installing, 
or using the App, you agree to these Terms.
"""),

                _card(theme, "Statement to Moonton & MLBB Team", """
First and foremost, I fully acknowledge and respect all Terms of Service and 
policies set by Moonton and Mobile Legends: Bang Bang. I understand the rules 
governing third-party tools and do not intend to claim affiliation or request 
special permissions beyond what is allowed.

ML Toolkit simply wishes to be considered as a supportive, community-friendly 
companion app — created to enhance user experience through safe, non-intrusive, 
and cosmetic-only features such as previews, hero information, UI tools, and 
community activities.

No gameplay mechanics are modified, no competitive advantages are provided, and 
no system is interfered with in any way.

Additionally, ML Toolkit’s rewarding system contributes positively to the 
MLBB ecosystem. Because users receive diamonds and other legitimate rewards, 
they naturally stay more engaged in the game and continue participating in 
events, ranked games, and overall MLBB activity.

This app fully supports MLBB’s fair-play principles and aims to help maintain a 
healthy, motivated, and active player community — never to replace or disrupt 
the official experience.
"""),

                _card(theme, "1. No Affiliation With Moonton", """
ML Toolkit is an independent tool and is NOT affiliated with, endorsed by, or associated with Moonton Games. All MLBB assets belong to Moonton.
"""),

                _card(theme, "2. Use of the App", """
ML Toolkit is provided for personal use only. You agree NOT to misuse the App, including:
""", bullets: [
                  "Reverse engineering the app",
                  "Reselling or redistributing the app commercially",
                  "Uploading malicious files",
                  "Using the app to bypass game security systems",
                  "Any use that violates MLBB's Terms of Service",
                ]),

                _card(theme, "3. Cosmetic-Only Usage", """
ML Toolkit provides cosmetic and UI customization only. It does NOT modify gameplay values, stats, mechanics, or competitive advantages.
"""),

                _card(theme, "4. Fair Play & Anti-Cheat Policy", """
You agree not to use ML Toolkit for cheating or unfair advantages.
Prohibited actions include:
""", bullets: [
                  "Map hacks",
                  "Radar or vision hacks",
                  "Drone view manipulation",
                  "Damage, stat, or cooldown hacks",
                  "Any gameplay-altering exploit",
                  "Any tool affecting competitive fairness",
                  "Users who promote or use cheats will be permanently restricted from reward features.",
                ]),

                _card(theme, "5. Anonymous Reward System", """
The reward and points system requires your **Mobile Legends User ID (UID)** and **in-game username (IGN)**.

These are used only as:
• A unique identifier for tracking points  
• Leaderboards and mini-game rankings  
• Displaying your in-app profile  
• Proper delivery of rewards to the correct MLBB account  
• Preventing duplicate or fraudulent accounts  

Your UID and IGN:
• Do NOT reveal your personal identity  
• Are NOT linked to emails, passwords, or login credentials  
• Are NOT used for advertising or tracking purposes  
• Are NOT shared with third-party companies  

No sensitive information (such as IP address, device identifiers, real name, or location) is collected.
"""),

                _card(theme, "6. User Responsibilities", """
As a user, you agree to:
""", bullets: [
                  "Use ML Toolkit responsibly",
                  "Avoid distributing copyrighted MLBB assets",
                  "Avoid harmful or abusive behavior",
                  "Comply with MLBB’s Terms and game rules",
                ]),

                _card(theme, "7. Intellectual Property", """
All MLBB game assets remain owned by Moonton Games.
Some cosmetic files displayed in the App may be copyrighted assets owned by their respective creators.
"""),

                _card(theme, "8. Monetization and Rewards", """
ML Toolkit may include ads, rewards, or monetization features.

You agree that:
• Rewards are not guaranteed  
• Rewards cannot be exchanged outside their intended use  
• Abuse of rewards may lead to restriction  
"""),

                _card(theme, "9. Disclaimer of Liability", """
ML Toolkit is provided “as is.”

We are not responsible for:
• Account bans caused by misuse  
• Damage from unauthorized modifications  
• Loss of game progress  
"""),

                _card(theme, "10. Termination", """
We reserve the right to terminate or restrict access to ML Toolkit for violations of these Terms.
"""),

                _card(theme, "11. Changes to Terms", """
We may update these Terms at any time. Continued use of the App signifies acceptance of updated Terms.
"""),

                _card(theme, "12. Contact Information", """
📩 Email: devcloper.url@gmail.com
🌐 Website: https://mlbb-toolkit.github.io
"""),

                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // HEADER BLOCK
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
              "Terms of Service",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              "Please read these Terms carefully before using ML Toolkit.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  // CARD COMPONENT
  Widget _card(
      ThemeData theme,
      String title,
      String body, {
        List<String>? bullets,
      }) {
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
            if (title.isNotEmpty)
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            if (title.isNotEmpty) const SizedBox(height: 18),

            // Body paragraph
            if (body.trim().isNotEmpty)
              Text(
                body.trim(),
                style: const TextStyle(height: 1.55, fontSize: 15.5),
              ),

            // Bullet list
            if (bullets != null) ...[
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: bullets.map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("•  "),
                        Expanded(
                          child: Text(
                            e,
                            style:
                            const TextStyle(height: 1.45, fontSize: 15.5),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Blob Widget
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
