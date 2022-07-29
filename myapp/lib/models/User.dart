//Contient les classes User et Users ;

class User {
  String? gender;
  String? firstName;
  String? lastName;
  String? address;
  String? email;
  String? dateOfBirth;
  String? imageUrl;
  String? phoneNumber;

  User(
      {this.gender,
      this.firstName,
      this.lastName,
      this.address,
      this.email,
      this.dateOfBirth,
      this.imageUrl,
      this.phoneNumber});

  User.fromJSON(Map<String, dynamic> jsonData) {
    this.gender = jsonData["gender"];
    this.firstName = jsonData["name"]["first"];
    this.lastName = jsonData["name"]["last"];
    this.address = jsonData["location"]["street"]["number"].toString() +
        " " +
        jsonData["location"]["street"]["name"];

    this.email = jsonData["email"];
    this.dateOfBirth = jsonData["dob"]["date"].toString();
    this.imageUrl = jsonData["picture"]["large"];
    this.phoneNumber = jsonData["phone"];
  }

  User.fromDatabaseMap(Map<String, dynamic> databaseMap) {
    this.gender = databaseMap["gender"];
    this.firstName = databaseMap["firstName"];
    this.lastName = databaseMap["lastName"];
    this.address = databaseMap["address"];

    this.email = databaseMap["email"];
    this.dateOfBirth = databaseMap["dateOfBirth"];
    this.imageUrl = databaseMap["imageURL"];
    this.phoneNumber = databaseMap["phoneNumber"];
  }

  Map<String, dynamic> convertToJSON() {
    Map<String, dynamic> userData = Map<String, dynamic>();
    if (this.gender != null) {
      userData["gender"] = this.gender;
    }
    if (this.firstName != null) {
      userData["firstName"] = this.firstName;
    }
    if (this.lastName != null) {
      userData["lastName"] = this.lastName;
    }
    if (this.address != null) {
      userData["address"] = this.address;
    }
    if (this.email != null) {
      userData["email"] = this.email;
    }
    if (this.dateOfBirth != null) {
      userData["dateOfBirth"] = this.dateOfBirth;
    }
    if (this.imageUrl != null) {
      userData["imageURL"] = this.imageUrl;
    }
    if (this.phoneNumber != null) {
      userData["phoneNumber"] = this.phoneNumber;
    }
    return userData;
  }
}

class Users {
  List<User>? users;

  Users({this.users});

  Users.fromJson(Map<String, dynamic> data) {
    if (data["results"] != null) {
      this.users = <User>[];
      data['results'].forEach((v) {
        users!.add(User.fromJSON(v));
      });
    }
  }

  Users.fromDatabase(List<Map<String, dynamic>> userDatabase) {
    if (userDatabase != null) {
      this.users = <User>[];
      for (Map<String, dynamic> user in userDatabase) {
        users?.add(User.fromJSON(user));
      }
    }
  }
}
