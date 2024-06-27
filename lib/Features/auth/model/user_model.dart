class UserModel {
   final String uId;
   final String name;
   final String phone;
   final String email;
   final String image;


  UserModel({
    required this.uId,
    required this.name,
    required this.phone,
    required this.email,
    required this.image,

  });
  

   factory UserModel.fromJson(Map<String, dynamic> json) {
     return UserModel(
         uId : json['uId'],
         name : json['name'],
         phone: json['phone'],
        email: json['email'],
        image: json['image'],
     );

  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'phone': phone,
      'email': email,
      'image' :image,
    };
  }
}
