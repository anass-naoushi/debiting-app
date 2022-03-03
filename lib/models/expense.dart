class Expense {
   String? title;
  DateTime? creationDate;
  num? amount;
  String? id;

  Expense({this.title, this.creationDate, this.amount,  this.id});

  Expense.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    creationDate = (json['creationDate']!=null?DateTime.parse(json['creationDate']):null)!;
    amount = json['amount'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['creationDate'] = creationDate.toString();
    data['amount'] = amount;
    data['id'] = id;
    return data;
  }
}