import 'package:flutter/material.dart';



class Grid extends StatelessWidget {
  const Grid({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.image,
    required this.onTap,
   
  });

  final String title;
  final String subtitle;
  final Color color;
  final String image;
  final  onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: InkWell(
          onTap: onTap,
          child: Card(
            color: color,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                    child: Text(title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(subtitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      "assets/$image",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
