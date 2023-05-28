import 'package:flutter/material.dart';
import 'package:project_3/model/packagemodel.dart';

class NotificationCard extends StatefulWidget {
  String msg;
  String title;
  String name;
  NotificationCard({
    required this.msg,
    required this.title,
    required this.name,
  });
  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    String x = 'Booking confirmed';
    String y = 'Booking Rejected';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 115,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Shadow color
              spreadRadius: 2, // Shadow spread radius
              blurRadius: 5, // Shadow blur radius
              offset: Offset(0, 3), // Shadow offset
            )
          ],
          color: Colors.white,
          border: Border.all(
            color: Colors.grey[200]!,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              const Icon(
                Icons.notification_important_rounded,
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.msg,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: widget.msg == x ? Colors.green : Colors.red,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Wrap(
                    spacing: 4,
                    children: [
                      Container(
                        width: 250,
                        child: Text(
                          '${widget.title} ${widget.msg} for ${widget.name}',
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
