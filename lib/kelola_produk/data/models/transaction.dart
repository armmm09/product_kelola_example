class Transacation {
  int? id, total;
  String? no_invoice;
  DateTime? date;

  Transacation({this.id, this.no_invoice, this.date, this.total});

  Transacation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    no_invoice = json['no_invoice'];
    date = json['date'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'no_invoice': no_invoice, 'date': date, 'total': total};
  }
}
