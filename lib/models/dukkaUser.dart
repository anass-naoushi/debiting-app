class DukkaUser {
  String? userName;
  String? email;
  String? userId;
  DateTime? creationDate;
  String? password;

  DukkaUser({this.userName, this.email, this.userId, this.creationDate});

  DukkaUser.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    userId = json['userId'];
    creationDate = json['creationDate']!=null? DateTime.parse(json['creationDate']):null;
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['email'] = email;
    data['userId'] = userId;
    data['creationDate'] = creationDate.toString();
    data['password']= password;
    return data;
  }
}