import 'package:flutter/material.dart';

class NotesListCard extends StatefulWidget {
  const NotesListCard({
    super.key,
    required this.title,
    required this.content,
    required this.footer,
    required this.bgColor,
    required this.onTap,
    this.textColor = Colors.black,
  });

  final String title;
  final String content;
  final String footer;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onTap;

  @override
  State<NotesListCard> createState() => _NotesListCardState();
}

class _NotesListCardState extends State<NotesListCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      mouseCursor: MouseCursor.defer,
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: widget.textColor,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: Text(
                widget.content,
                style: TextStyle(fontSize: 14, color: widget.textColor),
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.footer,
              style: TextStyle(
                fontSize: 12,
                color: widget.textColor.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
