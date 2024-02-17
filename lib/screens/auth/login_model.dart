class LoginModel {
  String? status;
  Null? message;
  Payload? payload;

  LoginModel({this.status, this.message, this.payload});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    payload =
        json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.payload != null) {
      data['payload'] = this.payload!.toJson();
    }
    return data;
  }
}

class Payload {
  Merchant? merchant;
  String? token;

  Payload({this.merchant, this.token});

  Payload.fromJson(Map<String, dynamic> json) {
    merchant = json['merchant'] != null
        ? new Merchant.fromJson(json['merchant'])
        : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.merchant != null) {
      data['merchant'] = this.merchant!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Merchant {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? mobile;
  String? mobileVerifiedAt;
  int? status;
  String? merchantType;
  String? createdAt;
  String? updatedAt;

  Merchant(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.mobile,
      this.mobileVerifiedAt,
      this.status,
      this.merchantType,
      this.createdAt,
      this.updatedAt});

  Merchant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    mobile = json['mobile'];
    mobileVerifiedAt = json['mobile_verified_at'];
    status = json['status'];
    merchantType = json['merchant_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['mobile'] = this.mobile;
    data['mobile_verified_at'] = this.mobileVerifiedAt;
    data['status'] = this.status;
    data['merchant_type'] = this.merchantType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
