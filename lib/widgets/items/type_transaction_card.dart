import 'package:flutter/material.dart';

class TypeTransactionCard extends StatelessWidget {
  final String count;
  final String? amount;
  final String description;
  final Color lineColor;

  const TypeTransactionCard({
    Key? key,
    required this.count,
    this.amount,
    required this.description,
    required this.lineColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 30,
            color: lineColor,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                amount ?? '',
                style: const TextStyle(
                  fontSize: 8,
                  color: Colors.black54,
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 8,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
