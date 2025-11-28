import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadPage extends StatelessWidget {
  const DownloadPage({super.key});

  static const String downloadUrl =
      "https://play.google.com/store/apps/details?id=com.elfilibustero.toolkit";

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
        theme.scaffoldBackgroundColor.withValues(alpha: 0.90),
        surfaceTintColor: Colors.transparent,
        title: const Text("Download ML Toolkit"),
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
          // Accent Blobs
          // -------------------------
          Positioned(
            top: -120,
            left: -80,
            child: _blob(
                theme.colorScheme.primary.withValues(alpha: 0.22), 240),
          ),
          Positioned(
            bottom: 120,
            right: -60,
            child:
            _blob(theme.colorScheme.secondary.withValues(alpha: 0.18), 200),
          ),

          // -------------------------
          // MAIN CONTENT
          // -------------------------
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: mobile ? 24 : 60,
                vertical: mobile ? 100 : 140,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      "ML Toolkit — Latest Version",
                      style: theme.textTheme.displaySmall,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    Text(
                      "Download the most stable and optimized version of ML Toolkit.",
                      style: theme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 40),

                    // -------------------------
                    // DOWNLOAD CARD (same style!)
                    // -------------------------
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: theme.cardColor.withValues(alpha: 0.85),
                        border: Border.all(
                          color:
                          theme.colorScheme.primary.withValues(alpha: 0.25),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.18),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),

                      child: Column(
                        children: [
                          Text(
                            "Latest Version: v2.0.0-fix1",
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 10),

                          Text(
                            "Tap the button below to download the app.",
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 26),

                          FilledButton(
                            onPressed: () async {
                              await launchUrl(
                                Uri.parse(downloadUrl),
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 26,
                              ),
                              child: Text("Download From Play Store"),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    Text(
                      "Need help? Contact devcloper.url@gmail.com",
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------
  // Reusable Accent Blob
  // ---------------------------------------
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
}
