class UserModel {
   String? uId;
   String? name;
   String? phone;
   String? email;
   String? image;


  UserModel({
    required this.uId,
    required this.name,
    required this.phone,
    required this.email,
    required this.image,

  });

   UserModel.fromJson(Map<String, dynamic> json) {
      uId = json['uId'];
      name = json['name'];
      phone= json['phone'];
      email= json['email'];
      image= json['image'];
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
