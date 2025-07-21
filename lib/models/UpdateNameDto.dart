class UpdateNameDto {
  final String firstName;
  final String lastName;

  UpdateNameDto({required this.firstName, required this.lastName});

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
      };
}