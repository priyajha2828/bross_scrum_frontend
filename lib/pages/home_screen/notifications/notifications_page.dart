import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/home_screen/notifications/notification_provider.dart';
import '../../../resources/color/custom_color.dart';
import '../../../routes/app_route.dart';


class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotificationsProvider>(context);

    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      appBar: AppBar(
        backgroundColor: CustomColor.bg_color(context),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircleAvatar(
            backgroundColor: Colors.cyan[700],
              child: TextButton(onPressed: (){
                Navigator.pushNamed(context, AppRoute.accountscreen);
              }, child:const Text(
                'PJ',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              ), )
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: CustomColor.textPrimary(context)),
            onPressed: () => _showSnoozeDialog(context, provider),
          ),
          IconButton(
            icon: Icon(Icons.settings_outlined, color: CustomColor.textPrimary(context)),
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.notificationsetting);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: Text(
              'Notifications',
              style: TextStyle(
                color: CustomColor.textPrimary(context),
                fontSize: 32,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildFilterChip(context, 'Direct', NotificationFilter.direct, provider),
                const SizedBox(width: 12),
                _buildFilterChip(context, 'Unread', NotificationFilter.unread, provider),
                const Spacer(),
                PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert , color: CustomColor.textMutedLabel(context)),
                    onSelected: (value){
                      if(value=="mark_all_read"){

                      }
                    },
                    itemBuilder: (context)=>[
                      PopupMenuItem<String>(
                        value:"mark_all_read",
                          child: Text("mark all as read")
                      )
                    ])
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: CustomPaint(
                        painter: EmptyStateIslandPainter(isDark: CustomColor.isDark(context)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      provider.selectedFilter == NotificationFilter.direct
                          ? 'No direct notifications'
                          : 'No unread notifications',
                      style: TextStyle(
                        color: CustomColor.textPrimary(context),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      provider.selectedFilter == NotificationFilter.direct
                          ? 'To see all notifications, clear the Direct notification filter.'
                          : 'To see both read and unread notifications, clear the Unread notification filter.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CustomColor.textMutedLabel(context),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: provider.clearFilters,
                      child: Text(
                        'Clear notification filters',
                        style: TextStyle(
                          color: CustomColor.actionBlueText(context),
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
        ],
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label, NotificationFilter filter, NotificationsProvider provider) {
    final bool isSelected = provider.selectedFilter == filter;
    return GestureDetector(
      onTap: () => provider.setFilter(filter),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? CustomColor.chipSelectedBg(context) : CustomColor.chipUnselectedBg(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.transparent : CustomColor.chipUnselectedBorder(context),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? CustomColor.chipSelectedText(context) : CustomColor.textMutedLabel(context),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  void _showSnoozeDialog(BuildContext context, NotificationsProvider provider) {
    showDialog(
      context: context,
      barrierColor: CustomColor.overlayBarrier(context),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: CustomColor.card_bg(context),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Snooze push notifications',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: CustomColor.textPrimary(context),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _buildSnoozeTile(context, '20 mins', const Duration(minutes: 20), provider),
                _buildSnoozeTile(context, '1 hr', const Duration(hours: 1), provider),
                _buildSnoozeTile(context, '4 hrs', const Duration(hours: 4), provider),
                _buildSnoozeTile(context, '24 hrs', const Duration(hours: 24), provider),
                _buildSnoozeTile(context, '2 days', const Duration(days: 2), provider),
                _buildSnoozeTile(context, '1 week', const Duration(days: 7), provider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSnoozeTile(BuildContext context, String label, Duration duration, NotificationsProvider provider) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: CustomColor.textPrimary(context),
        ),
      ),
      onTap: () {
        provider.snoozeNotifications(duration);
        Navigator.pop(context);
      },
    );
  }
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