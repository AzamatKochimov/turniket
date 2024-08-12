import 'dart:convert';

class ExpenseModel {
  bool status;
  List<Transaction> transactions;

  ExpenseModel({
    required this.status,
    required this.transactions,
  });

  factory ExpenseModel.fromRawJson(String str) => ExpenseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
    status: json["status"],
    transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
  };
}

class Transaction {
  int id;
  DateTime date;
  String amount;
  String type;
  String categoryId;

  Transaction({
    required this.id,
    required this.date,
    required this.amount,
    required this.type,
    required this.categoryId,
  });

  factory Transaction.fromRawJson(String str) => Transaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    amount: json["amount"],
    type: json["type"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "amount": amount,
    "type": type,
    "category_id": categoryId,
  };
}
