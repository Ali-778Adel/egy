class PaymentResponseEntity{
  final String?customerMail;
  final String?customerMobile;
  final String?expirationTime;
  final double?fawryFees;
  final String?merchantRefNumber;
  final String?orderAmount;
  final String?orderStatus;
  final String?paymentAmount;
  final String?paymentMethod;
  final String?referenceNumber;
  final double?shippingFees;
  final String?signature;
  final double?taxes;
  final int?statusCode;
  final String?statusDescription;
  final String?type;


  PaymentResponseEntity( {
    this.customerMail,
    this.customerMobile,
    this.expirationTime,
    this.fawryFees,
    this.merchantRefNumber,
    this.orderAmount,
    this.orderStatus,
    this.paymentAmount,
    this.paymentMethod,this.referenceNumber,
    this.shippingFees,this.signature,
    this.statusCode,
    this.statusDescription,this.type,
    this.taxes,
});

  factory PaymentResponseEntity.fromJson({required Map<String,dynamic>json}){
    return PaymentResponseEntity(
      customerMail: json['customerMail'],
      customerMobile:json['customerMobile'],
      expirationTime: json['expirationTime'],
      fawryFees:json['fawryFees'],
      merchantRefNumber: json['merchantRefNumber'],
      orderAmount:json['orderAmount'],
      orderStatus:json['orderStatus'],
      paymentAmount: json['paymentAmount'],
      paymentMethod: json['paymentMethod'],
      referenceNumber:json['referenceNumber'],
      shippingFees: json['shippingFees'],
      signature: json['signature'],
      statusCode: json['statusCode'],
      statusDescription: json['statusDescription'],
      taxes: json['taxes'],
    );
  }

  Map<String,dynamic>toJson(){
    return {
      'customerMail':customerMail,
      'customerMobile':customerMobile,
      'expirationTime':expirationTime,
      'fawryFees':fawryFees,
      'merchantRefNumber':merchantRefNumber,
      'orderAmount':orderAmount,
      'orderStatus':orderStatus,
      'paymentAmount':paymentAmount,
      'paymentMethod':paymentMethod,
      'referenceNumber':referenceNumber,
      'shippingFees':shippingFees,
      'signature':signature,
      'statusCode':statusCode,
      'statusDescription':statusDescription,
      'type':type,
      'taxes':taxes,
    };
  }
}