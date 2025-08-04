class OtpDto {
  final String Email;
  final String OTP_Number;

  OtpDto({required this.OTP_Number, required this.Email});
  Map<String, dynamic> toJson() {
    return {
      'email': Email,
      'otp': OTP_Number,
    };
  }
  factory OtpDto.fromJson(Map<String, dynamic> json) {
    return OtpDto(
      OTP_Number: json['otp'] as String,
      Email: json['email'] as String,
    );
  }
  @override
  String toString() {
    return 'OtpDto(OTP_Number: $OTP_Number, Email: $Email)';
  }
}