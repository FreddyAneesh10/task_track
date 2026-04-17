enum UserRole { admin, manager, associate }

enum UserStatus { active, inactive }

class AppUser {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final UserRole role;
  final UserStatus status;

  const AppUser({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.status,
  });

  String get fullName => '$firstName $lastName';
}
