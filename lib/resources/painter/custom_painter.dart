import 'package:flutter/material.dart';
import 'dart:math' as math;

class PartyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final conePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.blue[300]!, Colors.blue[700]!],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    final conePath = Path();
    conePath.moveTo(w * 0.30, h * 0.45);
    conePath.lineTo(w * 0.70, h * 0.45);
    conePath.lineTo(w * 0.62, h * 0.95);
    conePath.lineTo(w * 0.38, h * 0.95);
    conePath.close();
    canvas.drawPath(conePath, conePaint);

    final shadowPaint = Paint()..color = Colors.grey.withOpacity(0.3);
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.5, h * 0.95), width: w * 0.15, height: h * 0.03),
      shadowPaint,
    );

    final openingPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.blue[200]!, Colors.blue[500]!],
      ).createShader(Rect.fromLTWH(w * 0.28, h * 0.35, w * 0.44, h * 0.18));

    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.50, h * 0.45), width: w * 0.42, height: h * 0.16),
      openingPaint,
    );

    final arcPaint = Paint()
      ..color = Colors.blue[600]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.045
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(w * 0.45, h * 0.18), width: w * 0.28, height: h * 0.28),
      math.pi * 1.1,
      math.pi * 0.6,
      false,
      arcPaint,
    );

    _drawRotatedSquare(canvas, Offset(w * 0.20, h * 0.30), w * 0.06, Colors.deepOrange[400]!, 0.5);
    _drawRotatedSquare(canvas, Offset(w * 0.62, h * 0.22), w * 0.07, Colors.deepOrange[400]!, math.pi / 4);
    _drawRotatedRect(canvas, Offset(w * 0.22, h * 0.40), w * 0.10, w * 0.035, Colors.cyan[300]!, -math.pi / 4);
    _drawRotatedRect(canvas, Offset(w * 0.66, h * 0.34), w * 0.10, w * 0.035, Colors.cyan[300]!, -math.pi / 4);

    final squigglePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.012
      ..strokeCap = StrokeCap.round;

    _drawSquiggle(canvas, Offset(w * 0.30, h * 0.42), w * 0.10, squigglePaint);
    _drawSquiggle(canvas, Offset(w * 0.58, h * 0.40), w * 0.09, squigglePaint);

    final dotPaint = Paint()..color = Colors.orange[200]!;
    canvas.drawCircle(Offset(w * 0.18, h * 0.52), w * 0.022, dotPaint);
    canvas.drawCircle(Offset(w * 0.50, h * 0.52), w * 0.022, dotPaint);

    _drawRotatedSquare(canvas, Offset(w * 0.33, h * 0.60), w * 0.055, Colors.deepOrange[400]!, 0.3);

    final ribbonPaint = Paint()
      ..color = Colors.blue[600]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.045
      ..strokeCap = StrokeCap.round;
    final ribbonPath = Path();
    ribbonPath.moveTo(w * 0.20, h * 0.58);
    ribbonPath.quadraticBezierTo(w * 0.28, h * 0.65, w * 0.20, h * 0.70);
    ribbonPath.quadraticBezierTo(w * 0.14, h * 0.75, w * 0.22, h * 0.80);
    canvas.drawPath(ribbonPath, ribbonPaint);
  }

  void _drawRotatedSquare(Canvas canvas, Offset center, double size, Color color, double angle) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    final paint = Paint()..color = color;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset.zero, width: size, height: size),
        Radius.circular(size * 0.15),
      ),
      paint,
    );
    canvas.restore();
  }

  void _drawRotatedRect(Canvas canvas, Offset center, double w, double h, Color color, double angle) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    final paint = Paint()..color = color;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset.zero, width: w, height: h),
        Radius.circular(h * 0.3),
      ),
      paint,
    );
    canvas.restore();
  }

  void _drawSquiggle(Canvas canvas, Offset start, double length, Paint paint) {
    final path = Path();
    path.moveTo(start.dx, start.dy);
    path.relativeQuadraticBezierTo(length * 0.25, -length * 0.3, length * 0.5, 0);
    path.relativeQuadraticBezierTo(length * 0.25, length * 0.3, length * 0.5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class EmptyStateIslandPainter extends CustomPainter {
  final bool isDark;
  EmptyStateIslandPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final Paint skyPaint = Paint()..color = isDark ? const Color(0xFF1E293B) : const Color(0xFFE0F2FE);
    canvas.drawCircle(Offset(w * 0.5, h * 0.5), w * 0.45, skyPaint);

    final Paint seaPaint = Paint()..color = isDark ? const Color(0xFF1D4ED8) : const Color(0xFF2563EB);
    final Path seaPath = Path()
      ..moveTo(w * 0.1, h * 0.55)
      ..quadraticBezierTo(w * 0.3, h * 0.5, w * 0.5, h * 0.55)
      ..quadraticBezierTo(w * 0.7, h * 0.6, w * 0.9, h * 0.55)
      ..arcTo(Rect.fromCircle(center: Offset(w * 0.5, h * 0.5), radius: w * 0.45), 0.1, 3.0, false)
      ..close();
    canvas.drawPath(seaPath, seaPaint);

    final Paint islandPaint = Paint()..color = isDark ? const Color(0xFFD97706) : const Color(0xFFF59E0B);
    final Path islandPath = Path()
      ..moveTo(w * 0.15, h * 0.55)
      ..quadraticBezierTo(w * 0.5, h * 0.42, w * 0.85, h * 0.55)
      ..close();
    canvas.drawPath(islandPath, islandPaint);

    final Paint trunkPaint = Paint()
      ..color = isDark ? const Color(0xFF78350F) : const Color(0xFF92400E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    final Path trunkPath = Path()
      ..moveTo(w * 0.48, h * 0.5)
      ..quadraticBezierTo(w * 0.42, h * 0.35, w * 0.45, h * 0.22);
    canvas.drawPath(trunkPath, trunkPaint);

    final Paint leavesPaint = Paint()..color = isDark ? const Color(0xFF065F46) : const Color(0xFF10B981);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.4, h * 0.22), width: 35, height: 15), leavesPaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.52, h * 0.2), width: 35, height: 15), leavesPaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.46, h * 0.25), width: 20, height: 30), leavesPaint);

    final Paint umbrellaPaint = Paint()..color = isDark ? const Color(0xFFEF4444) : const Color(0xFFF87171);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.6, h * 0.5)
        ..lineTo(w * 0.75, h * 0.46)
        ..lineTo(w * 0.7, h * 0.52)
        ..close(),
      umbrellaPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}