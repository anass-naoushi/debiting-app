class Debit {
  String? title;
  String? debtor;
  String? debtorEmail;
  DateTime? creationDate;
  String? id;
  num? amount;
  DateTime? dueDate;

  Debit({this.debtor, this.debtorEmail, this.creationDate, this.amount,this.title, this.dueDate});

  Debit.fromJson(Map<String, dynamic> json) {
    title=json['title'];
    debtor = json['debtor'];
    debtorEmail = json['debtorEmail'];
    creationDate = json['creationDate']!=null?DateTime.parse(json['creationDate']):null;
    amount = json['amount'];
    id=json['id'];
    dueDate=json['dueDate']!=null?DateTime.parse(json['dueDate']):null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title']=title;
    data['debtor'] = debtor;
    data['debtorEmail'] = debtorEmail;
    data['creationDate'] = creationDate.toString();
    data['amount'] = amount;
    data['id']=id;
    data['dueDate']=dueDate.toString();
    return data;
  }
}