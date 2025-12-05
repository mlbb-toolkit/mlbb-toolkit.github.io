import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:url_launcher/url_launcher.dart';

import 'docs_page.dart';
import 'download_page.dart';
import 'legal_page.dart';
import 'privacy_page.dart';
import 'terms_page.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(const MlToolkitWeb());
}

class MlToolkitWeb extends StatelessWidget {
  const MlToolkitWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ML Toolkit',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/docs/privacy_policy': (context) => const PrivacyPage(),
        '/docs/legal_notice': (context) => const LegalPage(),
        '/docs/terms_of_service': (context) => const TermsPage(),
        '/download': (context) => const DownloadPage(),
        '/docs': (context) => const DocsPage(),
      },
    );
  }
}

Future<Map<String, dynamic>> loadJson() async {
  try {
    final data = await rootBundle.loadString("assets/app.json");
    return jsonDecode(data);
  } catch (e) {
    return {
      "error": true,
      "message": "JSON failed to load.",
      "details": e.toString(),
    };
  }
}


/* ----------------------------------------
              THEMES (Light + Dark)
---------------------------------------- */

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF6366F1),
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: const Color(0xFFF3F4F6),
  cardColor: Colors.white,
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF6366F1),
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: const Color(0xFF020817),
  cardColor: const Color(0xFF020617),
);

/* ----------------------------------------
          RESPONSIVE BREAKPOINTS
---------------------------------------- */

bool isMobile(BuildContext c) => MediaQuery.of(c).size.width < 650;

/* ----------------------------------------
          GLOBAL SCROLL KEYS
---------------------------------------- */

final Map<String, GlobalKey> sectionKeys = {
  'documentation': GlobalKey(),
  'download': GlobalKey(),
};

void scrollTo(String id) {
  final ctx = sectionKeys[id]?.currentContext;
  if (ctx == null) return;

  Scrollable.ensureVisible(
    ctx,
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeInOut,
  );
}

/* ----------------------------------------
          HOVER SCALE EFFECT
---------------------------------------- */

class HoverScale extends StatefulWidget {
  final Widget child;
  final double scale;
  final Duration duration;

  const HoverScale({
    super.key,
    required this.child,
    this.scale = 1.05,
    this.duration = const Duration(milliseconds: 180),
  });

  @override
  State<HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<HoverScale> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: hovering ? widget.scale : 1.0,
        duration: widget.duration,
        child: widget.child,
      ),
    );
  }
}

/* ----------------------------------------
      FADE + SLIDE ENTRANCE ANIMATION
---------------------------------------- */

class FadeSlide extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double offset;

  const FadeSlide({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.offset = 40,
  });

  @override
  State<FadeSlide> createState() => _FadeSlideState();
}

class _FadeSlideState extends State<FadeSlide>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _opacity = Tween<double>(begin: 0, end: 1).animate(_controller);
    _slide = Tween<Offset>(
      begin: Offset(0, widget.offset / 100),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

/* ----------------------------------------
                NAV BUTTON
---------------------------------------- */

class NavButton extends StatelessWidget {
  final String label;
  final String target;
  const NavButton({super.key, required this.label, required this.target});

  @override
  Widget build(BuildContext context) {
    return HoverScale(
      scale: 1.08,
      child: TextButton(
        onPressed: () => scrollTo(target),
        child: Text(label),
      ),
    );
  }
}

/* ----------------------------------------
                HOME PAGE
---------------------------------------- */

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  double _elevation = 0;
  double _appBarHeight = 72;
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = _scrollController.offset;

    setState(() {
      _scrollOffset = offset;
      _elevation = offset > 8 ? 8 : 0;
      _appBarHeight = offset > 8 ? 60 : 72;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // -------------------------------
  // Mobile menu
  // -------------------------------
  void _openMobileMenu() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context)
          .colorScheme
          .surface
          .withValues(alpha: 0.98),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Documentation'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const DocsPage()),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Privacy'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PrivacyPage()),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Download'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const DownloadPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final double parallaxOffset = _scrollOffset * 0.1;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: _elevation,
        backgroundColor: Theme.of(context)
            .scaffoldBackgroundColor
            .withValues(alpha: _scrollOffset > 10 ? 0.95 : 0.2),
        surfaceTintColor: Colors.transparent,
        toolbarHeight: mobile ? 60 : _appBarHeight,
        titleSpacing: mobile ? 10 : 24,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: const Image(
                image: AssetImage("assets/icon/icon.png"),
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            const Text('ML Toolkit', style: TextStyle(fontSize: 18)),
            const Spacer(),

            if (!mobile) ...[
              HoverScale(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const DocsPage()),
                    );
                  },
                  child: const Text("Documentation"),
                ),
              ),

              HoverScale(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PrivacyPage()),
                    );
                  },
                  child: const Text("Privacy"),
                ),
              ),

              const SizedBox(width: 12),
            ],

            if (!mobile)
              HoverScale(
                scale: 1.1,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const DownloadPage()),
                    );
                  },
                  child: const Text('Download'),
                ),
              )
            else
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: _openMobileMenu,
              ),
          ],
        ),
      ),

      body: Stack(
        children: [
          // Background gradient
          AnimatedContainer(
            duration: const Duration(seconds: 2),
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

          // Floating accent bubbles
          Positioned(
            top: -120 + parallaxOffset,
            left: -80,
            child: _AccentBlob(
              color: colorScheme.primary.withValues(alpha: 0.20),
              size: 260,
            ),
          ),
          Positioned(
            top: 240 - parallaxOffset,
            right: -60,
            child: _AccentBlob(
              color: colorScheme.secondary.withValues(alpha: 0.16),
              size: 220,
            ),
          ),

          // MAIN CONTENT
          SingleChildScrollView(
            controller: _scrollController,
            child: const Column(
              children: [
                HeroSection(),
                AppInfoSectionCard(),
                ScreenshotsSection(),
                FooterSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ----------------------------------------
        BACKGROUND BLOB DECORATIONS
---------------------------------------- */

class _AccentBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _AccentBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
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
}

/* ----------------------------------------
                HERO SECTION
---------------------------------------- */

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: mobile ? 80 : 120,
        horizontal: mobile ? 20 : 60,
      ),
      child: FadeSlide(
        child: mobile
            ? const Column(
          children: [
            _HeroText(),
            SizedBox(height: 40),
            HoverScale(child: HeroCard()),
            SizedBox(height: 20),
            HoverScale(child: HeroInfoCard()),
            SizedBox(height: 20),
          ],
        )
            : const Row(
          children: [
            Expanded(child: _HeroText()),
            SizedBox(width: 50),
            Column(
              children: [
                HoverScale(child: HeroCard()),
                SizedBox(height: 20),
                HoverScale(child: HeroInfoCard()),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class _HeroText extends StatelessWidget {
  const _HeroText();

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment:
      mobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Enhance Your Gaming Experience With Us',
          textAlign: mobile ? TextAlign.center : TextAlign.start,
          style: mobile ? textTheme.headlineMedium : textTheme.displaySmall,
        ),

        const SizedBox(height: 16),

        Text(
          'We\'re excited to welcome you! Enjoy a smooth, secure customization experience for every game session.',
          textAlign: mobile ? TextAlign.center : TextAlign.start,
        ),

        const SizedBox(height: 32),

        Wrap(
          spacing: 16,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: [
            HoverScale(
              child: FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DownloadPage()),
                  );
                },
                child: const Text('Download Now'),
              ),
            ),

            HoverScale(
              child: FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DocsPage()),
                  );
                },
                child: const Text('Docs'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class HeroCard extends StatelessWidget {
  const HeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: Container(
        width: mobile ? double.infinity : 320,
        decoration: BoxDecoration(
          color: theme.cardColor.withValues(alpha: 0.8),
          border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: 0.25),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary.withValues(alpha: 0.12),
                Colors.transparent,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(24),

          // ---------------------------
          // 🔥 New clean minimal card
          // ---------------------------
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ML Toolkit",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              Text(
                "Customize your MLBB experience with safe, fast, and secure cosmetic tools — all fully compliant and gameplay-safe.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeroInfoCard extends StatelessWidget {
  const HeroInfoCard({super.key});

  static const String storeUrl =
      "https://play.google.com/store/apps/details?id=com.elfilibustero.toolkit";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mobile = isMobile(context);

    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse(storeUrl));
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Container(
            width: mobile ? double.infinity : 320,
            decoration: BoxDecoration(
              color: theme.cardColor.withValues(alpha: 0.8),
              border: Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.25),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary.withValues(alpha: 0.12),
                    Colors.transparent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hero Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Explore hero information including roles, counters, stats, combos, synergies, and recommended builds — available in ML Toolkit.",
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Tap to explore →",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueAccent,
                    ),
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

class AppInfoSectionCard extends StatelessWidget {
  const AppInfoSectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<Map<String, dynamic>>(
      future: loadJson(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Container(
            padding: const EdgeInsets.all(24),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (!snap.hasData || snap.data!["error"] == true) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.cardColor.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              "❌ Failed to load app info",
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        final details = snap.data!["app_details"];
        final installs = formatInstalls(details["realInstalls"]);
        final score = details["score"];

        // Check if score is valid and > 0
        final bool hasValidScore = score != null &&
            (score is num ? score > 0 :
            (double.tryParse(score.toString()) ?? 0) > 0);

        final items = [
          (installs.isEmpty ? null : installs, "Downloads"),
          (details["version"], "Version"),
          if (hasValidScore) (score, "Rating"),
          // Keep raw score for star calculation
          (details["released"], "Released On"),
          (details["lastUpdatedOn"], "Last Updated On"),
        ].where((item) {
          final value = item.$1;
          return value != null && value
              .toString()
              .trim()
              .isNotEmpty;
        }).toList();

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 32),
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 32),
          decoration: BoxDecoration(
            color: theme.cardColor.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "App Information",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),

              // List info rows from JSON
              for (var item in items)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.$2,
                        style: TextStyle(
                          fontSize: 14.5,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.65),
                        ),
                      ),
                      if (item.$2 == "Rating")
                      // Display stars for rating
                        _buildStarRating(
                          context,
                          item.$1 is num ? item.$1.toDouble() :
                          double.tryParse(item.$1.toString()) ?? 0.0,
                        )
                      else
                        Text(
                          item.$1.toString(),
                          style: const TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // Star rating widget
  Widget _buildStarRating(BuildContext context, double rating) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RatingBar.builder(
          initialRating: rating,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          ignoreGestures: true,
          // Make it read-only
          itemCount: 5,
          itemSize: 20,
          itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) =>
              Icon(
                Icons.star,
                color: Colors.amber[700],
              ),
          onRatingUpdate: (_) {},
        ),
        const SizedBox(width: 8),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

String formatInstalls(int? value) {
  if (value == null) return "";
  if (value >= 1000000) {
    final m = value / 1000000;
    return "${m.toStringAsFixed(m >= 10 ? 0 : 1)}M";
  }
  if (value >= 1000) {
    final k = value / 1000;
    return "${k.toStringAsFixed(k >= 10 ? 0 : 1)}K";
  }
  return value.toString();
}

/* ----------------------------------------
              SCREENSHOTS SECTION
---------------------------------------- */

class ScreenshotsSection extends StatelessWidget {
  const ScreenshotsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final theme = Theme.of(context);

    final screenshots = <String>[
      'assets/screenshots/shot1.jpg',
      'assets/screenshots/shot2.jpg',
      'assets/screenshots/shot3.jpg',
      'assets/screenshots/shot4.jpg',
    ];

    return Container(
      padding: EdgeInsets.all(mobile ? 24 : 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeSlide(
            offset: 20,
            child: Text(
              'App Screenshots',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: 24),

          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: screenshots.map((img) {
              return FadeSlide(
                offset: 20,
                child: HoverScale(
                  scale: 1.04,
                  child: Container(
                    width: mobile
                        ? MediaQuery.of(context).size.width * 0.8
                        : 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: theme.colorScheme.primary.withValues(alpha: 0.18),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.18),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: AspectRatio(
                        aspectRatio: 9 / 20,
                        child: Image.asset(
                          img,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

/* ----------------------------------------
                FOOTER
---------------------------------------- */

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          const Text("© 2025 ML Toolkit"),
          const SizedBox(height: 4),
          const Text("Not affiliated with Moonton or Mobile Legends."),

          const SizedBox(height: 20),

          Wrap(
            spacing: 16,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PrivacyPage()),
                  );
                },
                child: const Text("Privacy Policy"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LegalPage()),
                  );
                },
                child: const Text("Legal Notice"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TermsPage()),
                  );
                },
                child: const Text("Terms of Service"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
