class Driver {
  Driver({
    required this.id,
    required this.name,
    required this.mobile,
    required this.licenseNo,
  });

  final int id;
  final String name;
  final String mobile;
  final String licenseNo;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        licenseNo: json["license_no"],
      );
}
