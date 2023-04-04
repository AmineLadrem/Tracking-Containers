class employe {
  int? EmployeID;
  String? Nom;
  String? Prenom;
  String? Role;
  String? Adresse;
  String? Email;
  String? Password;
  String? Phone;

  employe(this.EmployeID, this.Nom, this.Prenom, this.Role, this.Adresse,
      this.Email, this.Password);

  static List<employe> employees = [
    employe(
        1, 'hello', 'world', 'Admin', 'Alger', 'awpxrr@gmail.com', 'moha2002'),
    employe(3, 'world', 'hello', 'Pointeur', 'Alger', 'awpxrr@gmail.com',
        'moha2002')
  ];
}
