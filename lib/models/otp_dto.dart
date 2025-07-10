class OtpDto {
  final String OTP_Number;
  final String SessionID;
  
  OtpDto({required this.OTP_Number, required this.SessionID});
  Map<String, dynamic> toJson() {
    return {
      'OTP_Number': OTP_Number,
      'SessionID': SessionID,
    };
  }
  factory OtpDto.fromJson(Map<String, dynamic> json) {
    return OtpDto(
      OTP_Number: json['OTP_Number'] as String,
      SessionID: json['SessionID'] as String,
    );
  }
  @override
  String toString() {
    return 'OtpDto(OTP_Number: $OTP_Number, SessionID: $SessionID)';
  }
}