import '../constants/constant.dart';

class Bus {
  Bus({
    required this.name,
    required this.description,
    required this.seatCount,
    required this.seatLayout,
    required this.image,
  });

  final String name;
  final String description;
  final int seatCount;
  final SeatLayout seatLayout;
  final String image;

  factory Bus.fromJson(Map<String, dynamic> json) => Bus(
        name: json["name"],
        description: json["description"],
        seatCount: json["seat_count"],
        seatLayout: json["seat_layout"],
        image: json["image"],
      );
}
