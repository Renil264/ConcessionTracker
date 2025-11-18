import 'package:concession_tracker/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  final List<Map<String, dynamic>> notifications = const [
    {
      'orderId': '#12345',
      'message': 'Thank you for your order',
      'status': 'Preparing',
      'statusColor': Color(0xFFFDFFC4),
      'textColor': Color(0xFFF98601),
      'time': '12:42 PM',
      'date': '2025-11-10', // Today
    },
    {
      'orderId': '#71345',
      'message': 'Thank you for your order',
      'status': 'Payment Failed',
      'statusColor': Color.fromARGB(255, 255, 200, 196),
      'textColor': Color.fromARGB(255, 249, 9, 1),
      'time': '10:13 AM',
      'date': '2025-11-06', // Yesterday
    },
    {
      'orderId': '#77345',
      'message': 'Thank you for your order',
      'status': 'Ready to Pick',
      'statusColor': Color.fromARGB(255, 196, 227, 255),
      'textColor': Color.fromARGB(255, 0, 44, 127),
      'time': '11:22 AM',
      'date': '2025-11-05', // Older
    },
    {
      'orderId': '#87345',
      'message': 'Thank you for your order',
      'status': 'Completed',
      'statusColor': Color(0xFFC4FFE1),
      'textColor': Color(0xFF007F5F),
      'time': '01:02 PM',
      'date': '2025-11-01', // Older
    },
  ];

  List<Map<String, dynamic>> filterByDate(DateTime date) {
    return notifications.where((n) {
      final notifDate = DateTime.parse(n['date']);
      return notifDate.year == date.year &&
          notifDate.month == date.month &&
          notifDate.day == date.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));

    final todayNotifications = filterByDate(today);
    final yesterdayNotifications = filterByDate(yesterday);

    final olderNotifications = notifications.where((n) {
      final notifDate = DateTime.parse(n['date']);
      return !(notifDate.year == today.year &&
              notifDate.month == today.month &&
              notifDate.day == today.day) &&
          !(notifDate.year == yesterday.year &&
              notifDate.month == yesterday.month &&
              notifDate.day == yesterday.day);
    }).toList();

    // Sort older notifications by date descending
    olderNotifications.sort((a, b) =>
        DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppTheme.brandPurple),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          if (todayNotifications.isNotEmpty)
            _buildHeader("Today"),
          ...todayNotifications.map((item) => _buildNotificationCard(item)),

          if (yesterdayNotifications.isNotEmpty)
            _buildHeader("Yesterday"),
          ...yesterdayNotifications.map((item) => _buildNotificationCard(item)),

          if (olderNotifications.isNotEmpty)
            _buildHeader("Earlier"),
          ...olderNotifications.map((item) {
            final formattedDate =
                DateFormat('dd MMM yyyy').format(DateTime.parse(item['date']));
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.labelGray,
                    ),
                  ),
                  _buildNotificationCard(item),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppTheme.brandPurple,
        ),
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade50,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order ${item['orderId']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['message'],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: item['statusColor'],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text(
                    item['status'],
                    style: TextStyle(
                      color: item['textColor'],
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            item['time'],
            style: const TextStyle(
              fontSize: 13,
              color: AppTheme.labelGray,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
