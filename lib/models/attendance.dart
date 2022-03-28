class AttCheckInRequest {
  String? qrCodeUid;
  String? staffId;
  String? dob;
  double? latitude, longitude;
  String? deviceIdentifier;
  bool? isInside;
  String? message;

  AttCheckInRequest({
    this.qrCodeUid,
    this.staffId,
    this.dob,
    this.latitude,
    this.longitude,
    this.deviceIdentifier,
    this.isInside,
    this.message,
  });

  Map<String, String> toJson() => {
        "uid": qrCodeUid!,
        "staff_id": staffId!,
        "DOB": dob!,
        "y": latitude.toString(),
        "x": longitude.toString(),
        "deviceIdentifier": deviceIdentifier!
      };

  factory AttCheckInRequest.fromJson(Map<String, dynamic> json) {
    return AttCheckInRequest(
      isInside: json['isInside'],
      message: json['msm'],
    );
  }
}
