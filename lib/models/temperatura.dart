class Temperatura {
  final double celsius;
  final double fahrenheit;

  Temperatura({
    required this.celsius,
    required this.fahrenheit,
  });

  factory Temperatura.fromJson(Map<String, dynamic> json) {
    return Temperatura(
      celsius: json['celsius'],
      fahrenheit: json['fahrenheit'],
    );
  }
}