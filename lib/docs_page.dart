import 'package:flutter/material.dart';
import 'main.dart'; // isMobile(), isTablet(), FadeSlide, HoverScale

class DocsPage extends StatefulWidget {
  const DocsPage({super.key});

  @override
  State<DocsPage> createState() => _DocsPageState();
}

class _DocsPageState extends State<DocsPage> {
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
    final mobile = isMobile(context);
    final dark = theme.brightness == Brightness.dark;

    final showSidebar = !mobile;
    final parallax = _offset * 0.12;

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        elevation: _offset > 10 ? 1 : 0,
        backgroundColor: theme.scaffoldBackgroundColor
            .withValues(alpha: _offset > 10 ? 0.95 : 0.2),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text("ML Toolkit Docs"),
      ),

      // -------------------------------------------------------------
      // Homepage Background + Parallax
      // -------------------------------------------------------------
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
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

          Positioned(
            top: -120 + parallax,
            left: -80,
            child: _blob(
              theme.colorScheme.primary
                  .withValues(alpha: dark ? 0.20 : 0.25),
              260,
            ),
          ),

          Positioned(
            top: 260 - parallax,
            right: -60,
            child: _blob(
              theme.colorScheme.secondary
                  .withValues(alpha: dark ? 0.16 : 0.22),
              220,
            ),
          ),

          // -------------------------------------------------------------
          // Main Layout
          // -------------------------------------------------------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sticky Sidebar
              if (showSidebar)
                Container(
                  width: 260,
                  padding:
                  const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  decoration: BoxDecoration(
                    color: theme.cardColor.withValues(alpha: 0.05),
                    border: Border(
                      right: BorderSide(
                        color: theme.colorScheme.primary
                            .withValues(alpha: 0.10),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _tocHeader("Contents"),
                      const SizedBox(height: 20),
                      _tocButton(context, "Overview", "overview"),
                      _tocButton(context, "Features", "features"),
                      _tocButton(context, "Graphics Tips", "graphics"),
                      _tocButton(context, "HD Resources", "hdres"),
                      _tocButton(context, "Android 11+ Guide", "a11"),
                      _tocButton(context, "FAQ", "faq"),
                    ],
                  ),
                ),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  controller: _scroll,
                  padding: const EdgeInsets.symmetric(vertical: 120),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: mobile ? 16 : 40,
                        ),
                        child: Column(
                          children: [
                            _docCard(
                              context,
                              id: "overview",
                              title: "What is ML Toolkit?",
                              body: """
ML Toolkit is a cosmetic customization tool for Mobile Legends: Bang Bang.

It provides:
• Streamlined cosmetic imports  
• Skin/effect/UI file previews  
• Guides for graphics & HD resources  
• No hacks, no cheats, no gameplay modifications  
• 100% cosmetic & safe  

ML Toolkit will NEVER change gameplay mechanics or provide unfair advantages.
""",
                            ),

                            _docCard(
                              context,
                              id: "features",
                              title: "Features Overview",
                              body: """
• Clean and intuitive interface  
• Fast cosmetic import  
• Skin previews  
• Setup guides  
• Safe workflow with instructions  
• Automatic cleanup  
""",
                            ),

                            _docCard(
                              context,
                              id: "graphics",
                              title: "Graphics Tips",
                              child: Column(
                                children: [
                                  _image("assets/docs/graphics1.webp"),
                                  const SizedBox(height: 12),
                                  _center("""
Use Medium / High / Ultra graphics settings for stable skin models.

Some “Smooth” presets are deprecated and may cause invisible hero models.
"""),
                                ],
                              ),
                            ),

                            _docCard(
                              context,
                              id: "hdres",
                              title: "Download HD Resources",
                              child: Column(
                                children: [
                                  _image("assets/docs/hd_resources.webp"),
                                  const SizedBox(height: 12),
                                  _center("""
HD Resources are required for proper model rendering.

Recommended:
• HD Skin Display  
• HD Hero Display  
• HD In-Match Resources  
"""),
                                ],
                              ),
                            ),

                            _docCard(
                              context,
                              id: "a11",
                              title: "Android 11+ Scoped Storage Guide",
                              child: Column(
                                children: [
                                  _image("assets/docs/a11_tip1.webp"),
                                  const SizedBox(height: 12),
                                  _center("""
If ML Toolkit cannot detect MLBB directory:

1. Uninstall updates for “Files” or “Files by Google”  
2. This temporarily unlocks proper storage routing  
3. After setup, re-update the Files app  

Your security remains protected.
"""),
                                ],
                              ),
                            ),

                            _docCard(
                              context,
                              id: "faq",
                              title: "Frequently Asked Questions",
                              child: Column(
                                children: [
                                  _faq("Does ML Toolkit modify gameplay?",
                                      "No. ML Toolkit uses cosmetic files only."),
                                  _faq("Does it support hacks?",
                                      "Absolutely not. No hacks, cheats, or bypass tools."),
                                  _faq("Is ML Toolkit anonymous?",
                                      "Yes. No tokens, IP data, or personal details are collected."),
                                  _faq("Is Android 14 supported?",
                                      "Yes, but some manufacturers restrict storage access."),
                                ],
                              ),
                            ),

                            const SizedBox(height: 50),
                            Text(
                              "End of Documentation",
                              style: theme.textTheme.labelLarge,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------
  // HOMEPAGE-STYLE DOC CARD
  // -----------------------------------------------------------
  Widget _docCard(
      BuildContext context, {
        required String id,
        required String title,
        String? body,
        Widget? child,
      }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          _anchor(id),

          FadeSlide(
            offset: 18,
            child: Container(
              width: double.infinity,
              padding:
              const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
              decoration: BoxDecoration(
                color: theme.cardColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.14),
                ),
              ),

              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),

                  if (body != null)
                    _center(body),

                  if (child != null)
                    child,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------
  // Sidebar + TOC
  // -----------------------------------------------------------
  Widget _tocHeader(String text) => Text(
    text,
    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  );

  Widget _tocButton(BuildContext context, String label, String id) {
    return HoverScale(
      scale: 1.03,
      child: TextButton(
        onPressed: () {
          final key = _anchors[id];
          if (key?.currentContext != null) {
            Scrollable.ensureVisible(
              key!.currentContext!,
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOut,
            );
          }
        },
        child: Text(label),
      ),
    );
  }

  static final Map<String, GlobalKey> _anchors = {
    "overview": GlobalKey(),
    "features": GlobalKey(),
    "graphics": GlobalKey(),
    "hdres": GlobalKey(),
    "a11": GlobalKey(),
    "faq": GlobalKey(),
  };

  Widget _anchor(String id) => Container(key: _anchors[id]);

  // -----------------------------------------------------------
  // Helpers
  // -----------------------------------------------------------
  Widget _center(String text) => Text(
    text,
    style: const TextStyle(fontSize: 16, height: 1.45),
    textAlign: TextAlign.center,
  );

  Widget _image(String asset) => ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Image.asset(asset),
  );

  Widget _faq(String q, String a) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      children: [
        Text(
          "• $q",
          style: const TextStyle(
              fontSize: 17, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          a,
          style: const TextStyle(fontSize: 15),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );

  Widget _blob(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration:
      BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
