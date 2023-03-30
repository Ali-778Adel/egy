class FollowOrderModel{
  final int ?serviceId;
  final  int?serviceStatusId;
  final bool?isDiscount;
  final bool?isLiberalProfessions;
  final bool?isCommissioner;
  final String?userRefNumber;
  final String?cardId;
  final int?status;
  final int ?total;
  final String?notes;
  final String?customerMail;
  final String?customerMobile;
  final String?merchantRefNum;

  FollowOrderModel({this.serviceId,this.serviceStatusId,this.isDiscount,this.isLiberalProfessions,this.isCommissioner
  ,this.userRefNumber,
    this.total,
    this.cardId,
    this.status,
    this.notes,
    this.customerMail,
    this.customerMobile,
    this.merchantRefNum
  });
 factory FollowOrderModel.fromJson({required Map<String,dynamic>json}){
    return FollowOrderModel(
      serviceId: json['serviceId'],
      serviceStatusId:json['serviceStatusId'],
      isDiscount: json['is_discount'],
      isLiberalProfessions: json['is_LiberalProfessions'],
      isCommissioner: json['is_commissioner'],
      userRefNumber: json['userRefNum'],
      cardId: json['cardId'],
      total: json['total'],
      status: json['orderstatus'],
      notes: json['notes'],
      customerMail: json['email'],
      customerMobile: json['phoneNumber'],
      merchantRefNum: json['merchantRefNum']

    );
  }
}