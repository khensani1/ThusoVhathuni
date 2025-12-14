import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _floatController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tiles = <_NavTile>[
      _NavTile(label: 'User Profile', icon: Icons.person, route: '/profile', color: Colors.blue, emoji: '👤'),
      _NavTile(label: 'AI Diagnostics', icon: Icons.health_and_safety, route: '/diagnostics', color: Colors.red, emoji: '🤖'),
      _NavTile(label: 'Guidance', icon: Icons.local_hospital, route: '/guidance', color: Colors.green, emoji: '📚'),
      _NavTile(label: 'Health Tracking', icon: Icons.timeline, route: '/tracking', color: Colors.orange, emoji: '📊'),
      _NavTile(label: 'Reminders', icon: Icons.alarm, route: '/reminders', color: Colors.purple, emoji: '⏰'),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('ThusoVhathuni', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF2E7D32),
                      const Color(0xFF4CAF50),
                      const Color(0xFF81C784),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Animated background elements
                    AnimatedBuilder(
                      animation: _floatAnimation,
                      builder: (context, child) {
                        return Positioned(
                          top: 50 + _floatAnimation.value,
                          left: 20,
                          child: Transform.rotate(
                            angle: _floatAnimation.value * 0.1,
                            child: Icon(Icons.favorite, size: 30, color: Colors.white.withOpacity(0.3)),
                          ),
                        );
                      },
                    ),
                    AnimatedBuilder(
                      animation: _floatAnimation,
                      builder: (context, child) {
                        return Positioned(
                          top: 80 - _floatAnimation.value,
                          right: 30,
                          child: Transform.rotate(
                            angle: -_floatAnimation.value * 0.1,
                            child: Icon(Icons.medication, size: 25, color: Colors.white.withOpacity(0.3)),
                          ),
                        );
                      },
                    ),
                    AnimatedBuilder(
                      animation: _floatAnimation,
                      builder: (context, child) {
                        return Positioned(
                          top: 120 + _floatAnimation.value * 0.5,
                          left: 50,
                          child: Transform.rotate(
                            angle: _floatAnimation.value * 0.05,
                            child: Icon(Icons.water_drop, size: 20, color: Colors.white.withOpacity(0.3)),
                          ),
                        );
                      },
                    ),
                    // Main doctor icon with pulse animation
                    Center(
                      child: AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _pulseAnimation.value,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.3),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.health_and_safety,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Welcome text
                    const Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Text(
                        'Your Personal Health Companion',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final tile = tiles[index];
                  return _HomeCard(
                    label: tile.label,
                    icon: tile.icon,
                    color: tile.color,
                    emoji: tile.emoji,
                    onTap: () => Navigator.of(context).pushNamed(tile.route),
                  );
                },
                childCount: tiles.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeCard extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color color;
  final String emoji;
  final VoidCallback onTap;

  const _HomeCard({required this.label, required this.icon, required this.color, required this.emoji, required this.onTap});

  @override
  State<_HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<_HomeCard> with TickerProviderStateMixin {
  late AnimationController _tapController;
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _tapController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    
    _hoverController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _tapController, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: -0.1, end: 0.1).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );

    _bounceAnimation = Tween<double>(begin: 0, end: -5).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _tapController.dispose();
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _tapController.forward(),
      onTapUp: (_) {
        _tapController.reverse();
        widget.onTap();
      },
      onTapCancel: () => _tapController.reverse(),
      child: AnimatedBuilder(
        animation: Listenable.merge([_scaleAnimation, _rotationAnimation, _bounceAnimation]),
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.translate(
              offset: Offset(0, _bounceAnimation.value),
              child: Transform.rotate(
                angle: _rotationAnimation.value,
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          widget.color.withOpacity(0.15),
                          widget.color.withOpacity(0.05),
                          Colors.white,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: widget.color.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Emoji with animation
                        AnimatedBuilder(
                          animation: _hoverController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: 1.0 + (_hoverController.value * 0.1),
                              child: Text(
                                widget.emoji,
                                style: const TextStyle(fontSize: 32),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: widget.color.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            widget.icon,
                            size: 24,
                            color: widget.color,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.label,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: widget.color,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: widget.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Tap to explore',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: widget.color,
                                  fontSize: 10,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NavTile {
  final String label;
  final IconData icon;
  final String route;
  final Color color;
  final String emoji;
  const _NavTile({required this.label, required this.icon, required this.route, required this.color, required this.emoji});
}


