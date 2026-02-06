class MeModel {
  int? id;
  String? firstName;
  String? lastName;
  int? age;
  String? gender;
  String? email;
  String? phone;
  String? username;
  String? password;
  String? birthDate;
  String? image;


  MeModel(
      {this.id,
        this.firstName,
        this.lastName,
        this.age,
        this.gender,
        this.email,
        this.phone,
        this.username,
        this.password,
        this.birthDate,
        this.image,
      });

  // MeModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   firstName = json['firstName'];
  //   lastName = json['lastName'];
  //   age = json['age'];
  //   gender = json['gender'];
  //   email = json['email'];
  //   phone = json['phone'];
  //   username = json['username'];
  //   password = json['password'];
  //   birthDate = json['birthDate'];
  //   image = json['image'];
  // }

  factory MeModel.fromDbMap(Map<String, dynamic> map) {
    return MeModel(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      age: map['age'],
      gender: map['gender'],
      email: map['email'],
      image: map['image'],
    );
  }


  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['firstName'] = this.firstName;
  //   data['lastName'] = this.lastName;
  //   data['age'] = this.age;
  //   data['gender'] = this.gender;
  //   data['email'] = this.email;
  //   data['phone'] = this.phone;
  //   data['username'] = this.username;
  //   data['password'] = this.password;
  //   data['birthDate'] = this.birthDate;
  //   data['image'] = this.image;
  //   return data;
  // }

  Map<String, dynamic> toDbMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'email': email,
      'image': image,
    };
  }


}


