import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Premium Portal App',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),
      home: MainNavigationShell(
        onThemeToggle: _toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Main Navigation Shell with floating bottom nav
// ─────────────────────────────────────────────
class MainNavigationShell extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const MainNavigationShell({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final bgStart = isDark ? const Color(0xFF0F172A) : const Color(0xFFEEF2F6);
    final bgEnd   = isDark ? const Color(0xFF1E1B4B) : const Color(0xFFD8E2EC);

    final screens = [
      HomeTab(onThemeToggle: widget.onThemeToggle, isDarkMode: isDark),
      ExploreTab(onThemeToggle: widget.onThemeToggle, isDarkMode: isDark),
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [bgStart, bgEnd],
          ),
        ),
        child: Stack(
          children: [
            IndexedStack(index: _currentTab, children: screens),

            // Floating glassmorphic bottom nav
            Positioned(
              left: 24, right: 24, bottom: 24,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    height: 72,
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withOpacity(0.04)
                          : Colors.black.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withOpacity(0.08)
                            : Colors.black.withOpacity(0.06),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _navItem(0, Icons.dashboard_outlined, Icons.dashboard_rounded, 'Home'),
                        _navItem(1, Icons.explore_outlined,   Icons.explore_rounded,   'Explore'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData icon, IconData activeIcon, String label) {
    final isSelected = _currentTab == index;
    final color = isSelected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurface.withOpacity(0.4);

    return GestureDetector(
      onTap: () => setState(() => _currentTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isSelected ? activeIcon : icon, color: color, size: 24),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(label,
                  style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Home Tab
// ─────────────────────────────────────────────
class HomeTab extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const HomeTab({super.key, required this.onThemeToggle, required this.isDarkMode});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _quoteIndex = 0;

  final List<Map<String, String>> _quotes = [
    {'quote': 'The best way to predict the future is to invent it.', 'author': 'Alan Kay'},
    {'quote': 'Simplicity is the soul of efficiency.',               'author': 'Austin Freeman'},
    {'quote': 'Make it simple, but significant.',                    'author': 'Don Draper'},
    {'quote': 'First, solve the problem. Then, write the code.',     'author': 'John Johnson'},
  ];

  void _cycleQuote() => setState(() => _quoteIndex = (_quoteIndex + 1) % _quotes.length);

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final isDark = widget.isDarkMode;
    final glassBg     = isDark ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.02);
    final glassBorder = isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.06);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Colors.indigo, Colors.purple]),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.blur_on_rounded, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Text('Antigravity',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                  ]),
                  IconButton(
                    icon: Icon(
                      isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                      color: theme.colorScheme.onSurface,
                    ),
                    onPressed: widget.onThemeToggle,
                  ),
                ],
              ),
            ),

            // ── Scrollable body ──
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),

                    // Welcome hero card
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOut,
                      builder: (ctx, v, child) =>
                          Opacity(opacity: v.clamp(0.0, 1.0), child: child),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isDark
                                ? [
                                    Colors.indigo.shade900.withOpacity(0.6),
                                    Colors.purple.shade900.withOpacity(0.6)
                                  ]
                                : [Colors.indigo.shade100, Colors.purple.shade100],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.indigo.withOpacity(isDark ? 0.2 : 0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(isDark ? 0.1 : 0.4),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'WELCOME HOME',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.5,
                                  color: isDark
                                      ? Colors.indigo.shade200
                                      : Colors.indigo.shade800,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ShaderMask(
                              shaderCallback: (b) => const LinearGradient(
                                colors: [Colors.indigoAccent, Colors.purpleAccent],
                              ).createShader(b),
                              child: const Text(
                                'Hello, World!',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Experience the next generation of Flutter development. Clean, responsive, and visually stunning.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(0.7),
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Quote glass card
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: glassBg,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: glassBorder),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('INSIGHT OF THE DAY',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2,
                                        color: theme.colorScheme.primary,
                                      )),
                                  const Icon(Icons.format_quote_rounded,
                                      color: Colors.indigoAccent, size: 28),
                                ],
                              ),
                              const SizedBox(height: 12),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: Column(
                                  key: ValueKey(_quoteIndex),
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '"${_quotes[_quoteIndex]['quote']}"',
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                        height: 1.4,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      '— ${_quotes[_quoteIndex]['author']}',
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onSurface.withOpacity(0.5),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: _cycleQuote,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: theme.colorScheme.primary.withOpacity(0.2)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.refresh_rounded,
                                          size: 18, color: theme.colorScheme.primary),
                                      const SizedBox(width: 8),
                                      Text('Next Insight',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.primary,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 110),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Explore Tab
// ─────────────────────────────────────────────
class ExploreTab extends StatelessWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const ExploreTab({super.key, required this.onThemeToggle, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final categories = <Map<String, dynamic>>[
      {
        'title': 'Stunning Layouts',
        'subtitle': 'Glassmorphic cards and gradient design tokens.',
        'icon': Icons.layers_outlined,
        'color': Colors.pinkAccent,
        'tag': 'Aesthetics',
        'content':
            'Aesthetic designs are crucial to modern applications. By applying linear gradients and blur backdrops, we elevate a standard application into a premium experience.',
      },
      {
        'title': 'Smooth Motion',
        'subtitle': 'Micro-animations and physics-based transitions.',
        'icon': Icons.animation_rounded,
        'color': Colors.amberAccent,
        'tag': 'Interaction',
        'content':
            'Micro-interactions guide user actions seamlessly. AnimatedSwitcher for context-switching elements keeps the screen interactive and alive.',
      },
      {
        'title': 'High Performance',
        'subtitle': 'Techniques for optimising LCP and rendering speed.',
        'icon': Icons.bolt_rounded,
        'color': Colors.cyanAccent,
        'tag': 'Performance',
        'content':
            'High performance ensures fluid 60fps rendering in Flutter. Keep widgets modular, use const constructors, and avoid heavy tasks inside build methods.',
      },
      {
        'title': 'Design Systems',
        'subtitle': 'Primitive, semantic, and component token hierarchy.',
        'icon': Icons.grid_view_rounded,
        'color': Colors.greenAccent,
        'tag': 'Systematic',
        'content':
            'A Design System forms the foundation of modern interfaces. Standardized token padding, margins, and type scales guarantee architectural harmony.',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Colors.indigo, Colors.purple]),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.explore_rounded, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Text('Explore',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                  ]),
                  IconButton(
                    icon: Icon(
                      isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                      color: theme.colorScheme.onSurface,
                    ),
                    onPressed: onThemeToggle,
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: categories.length + 1,
                itemBuilder: (context, i) {
                  if (i == categories.length) return const SizedBox(height: 110);
                  final item = categories[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ExploreDetailPage(item: item, isDarkMode: isDarkMode),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.white.withOpacity(0.02)
                              : Colors.black.withOpacity(0.01),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isDarkMode
                                ? Colors.white.withOpacity(0.06)
                                : Colors.black.withOpacity(0.04),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: (item['color'] as Color).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(item['icon'] as IconData,
                                  color: item['color'] as Color, size: 28),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (item['tag'] as String).toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      color: item['color'] as Color,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(item['title'] as String,
                                      style: const TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['subtitle'] as String,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: theme.colorScheme.onSurface.withOpacity(0.5),
                                      height: 1.3,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: theme.colorScheme.onSurface.withOpacity(0.2)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Explore Detail Page with back button
// ─────────────────────────────────────────────
class ExploreDetailPage extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool isDarkMode;

  const ExploreDetailPage({super.key, required this.item, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final theme    = Theme.of(context);
    final bgStart  = isDarkMode ? const Color(0xFF0F172A) : const Color(0xFFEEF2F6);
    final bgEnd    = isDarkMode ? const Color(0xFF1E1B4B) : const Color(0xFFD8E2EC);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [bgStart, bgEnd],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom header with back button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.white.withOpacity(0.04)
                                : Colors.black.withOpacity(0.03),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isDarkMode
                                  ? Colors.white.withOpacity(0.08)
                                  : Colors.black.withOpacity(0.06),
                            ),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios_new_rounded,
                                color: theme.colorScheme.onSurface, size: 18),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text('Details',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            (item['color'] as Color).withOpacity(0.2),
                            (item['color'] as Color).withOpacity(0.05),
                          ]),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                              color: (item['color'] as Color).withOpacity(0.15)),
                        ),
                        child: Column(
                          children: [
                            Icon(item['icon'] as IconData,
                                color: item['color'] as Color, size: 56),
                            const SizedBox(height: 16),
                            Text(item['title'] as String,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 8),
                            Text((item['tag'] as String).toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: item['color'] as Color,
                                  letterSpacing: 2.0,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text('OVERVIEW',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            color: theme.colorScheme.onSurface.withOpacity(0.4),
                          )),
                      const SizedBox(height: 12),
                      Text(item['content'] as String,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            height: 1.6,
                            color: theme.colorScheme.onSurface.withOpacity(0.8),
                          )),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
