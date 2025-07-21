class UpdateUsernameDto {
  final String username;

  UpdateUsernameDto({required this.username});

  Map<String, dynamic> toJson() => {
        'username': username,
      };
}