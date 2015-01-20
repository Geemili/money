
namespace Money.Model {
	public class Account : GLib.Object {
		public string name;
		public Balance[] balances;
		public Action[] deposits;
		public Action[] withdrawals;
		public uint next_balance_id;
	}

	public class Balance : GLib.Object {
		public uint id;
		public string name;
		public int deposit_weight;
		public int withdraw_weight;
	}

	public class Action : GLib.Object {
		public int64 timestamp;
		public uint balance_id;
		public uint amount;
		public string description;
	}

	public Account init_model() {
		var account = new Account();
		account.balances = new Balance[0];
		account.deposits = new Action[0];
		account.withdrawals = new Action[0];
		account.next_balance_id = 1; // 0 is the account, 1 is the first useable.
		return account;
	}
}