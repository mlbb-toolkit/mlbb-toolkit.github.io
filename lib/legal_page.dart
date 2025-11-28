import 'package:flutter/material.dart';

class LegalPage extends StatelessWidget {
  const LegalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final mobile = MediaQuery.of(context).size.width < 650;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 6,
        backgroundColor:
        theme.scaffoldBackgroundColor.withValues(alpha: 0.92),
        surfaceTintColor: Colors.transparent,
        title: const Text("Legal Notice"),
      ),

      body: Stack(
        children: [
          // -------------------------
          // Gradient Background
          // -------------------------
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
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

          // -------------------------
          // Accent floating blobs
          // -------------------------
          Positioned(
            top: -120,
            left: -80,
            child: _blob(
              theme.colorScheme.primary.withValues(alpha: 0.22),
              240,
            ),
          ),
          Positioned(
            bottom: 120,
            right: -60,
            child: _blob(
              theme.colorScheme.secondary.withValues(alpha: 0.18),
              220,
            ),
          ),

          // -------------------------
          // MAIN CONTENT (FULL WIDTH)
          // -------------------------
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: mobile ? 16 : 60,
              vertical: mobile ? 100 : 150,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER
                Text(
                  "ML Toolkit – Legal Notice & Copyright",
                  style: theme.textTheme.displaySmall,
                ),
                const SizedBox(height: 14),
                Text(
                  "This legal notice applies to all users of ML Toolkit. Please read carefully.",
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 40),

                // -------------------------
                // LEGAL CARDS — FULL WIDTH
                // -------------------------
                _legalCard(
                  theme,
                  title: "Statement to Moonton & MLBB Team",
                  body:
                  "ML Toolkit fully respects the Terms of Service and policies set by Moonton "
                      "and Mobile Legends: Bang Bang. We understand the limitations placed on "
                      "third-party tools and do not request any special permissions or exemptions.\n\n"

                      "This app exists purely as a supportive, community-oriented companion that "
                      "offers cosmetic previews, UI helpers, and player-driven features without "
                      "modifying gameplay or interfering with MLBB systems in any way.\n\n"

                      "We ask only that ML Toolkit be considered as a positive, non-intrusive tool "
                      "that encourages player engagement. The optional reward system—where users "
                      "may earn diamonds or in-game benefits—ultimately motivates players to stay "
                      "active in MLBB, participate more frequently, and remain invested in the game.\n\n"

                      "ML Toolkit is built with full awareness of MLBB’s rules and is designed to "
                      "support the community while upholding fair play and the integrity of the game.",
                ),

                _legalCard(
                  theme,
                  title: "1. No Affiliation With Moonton",
                  body:
                  "ML Toolkit is an independent tool and is NOT affiliated with, sponsored by, or endorsed by Moonton or Mobile Legends: Bang Bang.",
                ),

                _legalCard(
                  theme,
                  title: "2. Copyrighted Materials",
                  body:
                  "All hero names, images, skills, skins, and assets belong exclusively to Moonton. ML Toolkit does not claim ownership of any MLBB content.",
                ),

                _legalCard(
                  theme,
                  title: "3. Purpose of ML Toolkit",
                  body:
                  "This app provides cosmetic customization and interface improvements only. It does NOT modify gameplay.",
                ),

                _legalCard(
                  theme,
                  title: "4. Monetization & Rewards",
                  body:
                  "ML Toolkit may include monetization features to fund development and giveaways. The app does NOT sell copyrighted MLBB assets.",
                ),

                _legalCard(
                  theme,
                  title: "5. Use of Game Files",
                  body:
                  "Provided files may interface with MLBB for cosmetic use only. These files cannot and must not alter gameplay mechanics.",
                ),

                _legalCard(
                  theme,
                  title: "6. User Responsibility",
                  body:
                  "Users are responsible for their usage. Redistribution of copyrighted MLBB assets is prohibited.",
                ),

                _legalCard(
                  theme,
                  title: "7. DMCA Compliance",
                  body:
                  "ML Toolkit will immediately remove any content upon valid DMCA request from Moonton or authorized rights holders.",
                ),

                _legalCard(
                  theme,
                  title: "8. No Liability for Misuse",
                  body:
                  "The developer is not responsible for account bans or issues caused by misuse, modified game files, or ToS violations.",
                ),

                // -------------------------
                // SECTION 9 – ANTI-CHEAT
                // -------------------------
                _legalCard(
                  theme,
                  title: "9. Fair Play Commitment & Prohibited Content",
                  body:
                  "ML Toolkit strictly opposes cheating and gameplay manipulation. The app does NOT support or allow:",
                  extra: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      _bullet(theme, "Map hacks / Radar hacks"),
                      _bullet(theme, "Drone view / extended map vision"),
                      _bullet(theme, "Damage/defense/stat cheats"),
                      _bullet(theme, "Speed or cooldown hacks"),
                      _bullet(theme, "Any gameplay-altering modifications"),

                      const SizedBox(height: 14),
                      Text(
                        "ML Toolkit only provides cosmetic features and NEVER alters gameplay.",
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Users promoting cheats will be permanently banned.",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
                Center(
                  child: Text(
                    "Last updated: January 2025",
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------
  // Accent blob
  // -------------------------
  Widget _blob(Color color, double size) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }

  // -------------------------
  // Modern legal card — FULL WIDTH
  // -------------------------
  Widget _legalCard(
      ThemeData theme, {
        required String title,
        required String body,
        Widget? extra,
      }) {
    return Container(
      width: double.infinity, // 🔥 ensures full width
      margin: const EdgeInsets.only(bottom: 28),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: theme.cardColor.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.20),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withValues(alpha: 0.15),
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),

          Text(body, style: theme.textTheme.bodyMedium),

          if (extra != null) ...[
            const SizedBox(height: 14),
            extra,
          ]
        ],
      ),
    );
  }

  // -------------------------
  // Bullet UI
  // -------------------------
  Widget _bullet(ThemeData theme, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• "),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
