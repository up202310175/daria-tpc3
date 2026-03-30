enum PowerBankStatus { available, reserved }

class PowerBank {
  final String id;
  final int batteryPercent;
  final String stationName;
  PowerBankStatus status;

  PowerBank({
    required this.id,
    required this.batteryPercent,
    required this.stationName,
    required this.status,
  });
}