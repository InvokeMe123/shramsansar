class SocialAccountsModel {
  final List<AccountDetails> accounts;

  SocialAccountsModel({required this.accounts});

  // empty initializer
  SocialAccountsModel.empty() : accounts = [];

  factory SocialAccountsModel.fromJson(List<dynamic> json) {
    final List<AccountDetails> accounts = [];
    for (final account in json) {
      accounts.add(AccountDetails(id: account['id'], name: account['name']));
    }
    return SocialAccountsModel(accounts: accounts);
  }
}

class AccountDetails {
  final int id;
  final String name;

  AccountDetails({required this.id, required this.name});
}
