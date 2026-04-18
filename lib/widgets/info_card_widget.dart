import 'package:flutter/material.dart';

class InfoCardWidget extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final String time;
  final String rating;
  final Color color;

  const InfoCardWidget({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.time,
    required this.color,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    height: 80,
                    width: 80,
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                  child: Center(
                    child: Text(
                      rating,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 5,)
      ],
    );
  }
}
