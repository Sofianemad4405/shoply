class PaymentMethod {
  final String type;
  final CreditCard? creditCard;
  final PayPal? payPal;

  PaymentMethod({required this.type, this.creditCard, this.payPal});

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      type: json["type"],
      creditCard:
          json["creditCard"] != null
              ? CreditCard.fromJson(json["creditCard"])
              : null,
      payPal: json["payPal"] != null ? PayPal.fromJson(json["payPal"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "creditCard": creditCard?.toJson(),
      "payPal": payPal?.toJson(),
    };
  }
}

class CreditCard {
  final String cardNumber;
  final String cardHolderName;
  final String cardExpiryDate;
  final String cardCvv;

  CreditCard({
    required this.cardNumber,
    required this.cardHolderName,
    required this.cardExpiryDate,
    required this.cardCvv,
  });

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
      cardNumber: json["cardNumber"],
      cardHolderName: json["cardHolderName"],
      cardExpiryDate: json["cardExpiryDate"],
      cardCvv: json["cardCvv"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cardNumber": cardNumber,
      "cardHolderName": cardHolderName,
      "cardExpiryDate": cardExpiryDate,
      "cardCvv": cardCvv,
    };
  }
}

class PayPal {
  final String email;

  PayPal({required this.email});

  factory PayPal.fromJson(Map<String, dynamic> json) {
    return PayPal(email: json["email"]);
  }

  Map<String, dynamic> toJson() {
    return {"email": email};
  }
}
