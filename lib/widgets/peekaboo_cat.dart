import 'dart:math';
import 'package:flutter/material.dart';

class PeekabooCat extends StatefulWidget {
  const PeekabooCat({super.key});

  @override
  State<PeekabooCat> createState() => _PeekabooCatState();
}

class _PeekabooCatState extends State<PeekabooCat>
    with SingleTickerProviderStateMixin {
  final _rand = Random();
  late final AnimationController _ctrl;
  late final Animation<double> _fade;

  double _top = 0.5;
  double _left = 0.5;
  String _assetPath = 'assets/ui/cat_corner.png';
  double _rotation = 0;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );

    _runCycle();
  }

  void _runCycle() async {
    await Future.delayed(Duration(seconds: 2 + _rand.nextInt(4)));

    if (!mounted) return;

    final isCorner = _rand.nextBool();
    final screen = MediaQuery.of(context).size;

    if (isCorner) {
      _assetPath = 'assets/ui/cat_corner.png';

  // choosingcorners
      final corner = _rand.nextInt(4);
      switch (corner) {
        case 0: // top-left
          _top = 0.02;
          _left = 0.02;
          _rotation = 0;
          break;
        case 1: // top-right
          _top = 0.02;
          _left = screen.width - 80;
          _rotation = pi / 2;
          break;
        case 2: // bottom-left
          _top = screen.height - 80;
          _left = 0.02;
          _rotation = -pi / 2;
          break;
        case 3: // bottom-right
          _top = screen.height - 80;
          _left = screen.width - 80;
          _rotation = pi;
          break;
      }
    } else {
      _assetPath = 'assets/ui/cat_side.png';

      
      final edge = _rand.nextInt(4);
      switch (edge) {
        case 0: // top
          _top = 0;
          _left = _rand.nextDouble() * (screen.width - 80);
          break;
        case 1: // right
          _top = _rand.nextDouble() * (screen.height - 80);
          _left = screen.width - 80;
          break;
        case 2: // bottom
          _top = screen.height - 80;
          _left = _rand.nextDouble() * (screen.width - 80);
          break;
        case 3: // left
          _top = _rand.nextDouble() * (screen.height - 80);
          _left = 0;
          break;
      }
      _rotation = 0;
    }

    setState(() {});
    await _ctrl.forward();
    await Future.delayed(const Duration(seconds: 2));
    await _ctrl.reverse();

    if (mounted) _runCycle();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _top,
      left: _left,
      child: FadeTransition(
        opacity: _fade,
        child: Transform.rotate(
          angle: _rotation,
          child: Image.asset(_assetPath, width: 80),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }
}
