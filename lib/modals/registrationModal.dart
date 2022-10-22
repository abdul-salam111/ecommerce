class RegistrationModal {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? confirmPassword;
  RegistrationModal(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.confirmPassword});
  factory RegistrationModal.fromMap(Map<String, dynamic> json) {
    return RegistrationModal(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword
    };
  }
}
