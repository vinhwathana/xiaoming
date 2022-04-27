import 'dart:convert';

List<CertificateStatistic> certificateStatisticFromMap(String str) =>
    List<CertificateStatistic>.from(
        json.decode(str).map((x) => CertificateStatistic.fromMap(x)));

String certificateStatisticToMap(List<CertificateStatistic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class CertificateStatistic {
  CertificateStatistic({
    required this.certificateTpId,
    required this.certName,
    required this.total,
  });

  String certificateTpId;
  String certName;
  int total;

  factory CertificateStatistic.fromMap(Map<String, dynamic> json) =>
      CertificateStatistic(
        certificateTpId: json["certificate_tp_id"],
        certName: json["cert_name"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "certificate_tp_id": certificateTpId,
        "cert_name": certName,
        "total": total,
      };

  @override
  String toString() {
    return 'CertificateStatistic{certificateTpId: $certificateTpId, certName: $certName, total: $total}';
  }
}
