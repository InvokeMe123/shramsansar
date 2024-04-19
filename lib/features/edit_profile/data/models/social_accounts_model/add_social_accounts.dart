class AddSocialAccountsModel {
  List<Accounts>? accounts;

  AddSocialAccountsModel({this.accounts});

  AddSocialAccountsModel.fromJson(Map<String, dynamic> json) {
    if (json['accounts'] != null) {
      accounts = <Accounts>[];
      json['accounts'].forEach((v) {
        accounts!.add(Accounts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (accounts != null) {
      data['accounts'] = accounts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Accounts {
  String? name;
  String? url;

  Accounts({this.name, this.url});

  Accounts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
