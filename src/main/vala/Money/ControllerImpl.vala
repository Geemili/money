

namespace Money.Controller {
	class BasicController : Money.Controller.Controller {

		private Money.Model.Account _account;
		private Money.View.Renderer _renderer;

		public override Money.Model.Account model {
			get {return _account;}
			set {_account = value;}
		}

		public override Money.View.Renderer view {
			get {return _renderer;}
			set {_renderer = value;}
		}

		public override void balance_deposit(uint balance_id, uint amount, string description) {
			var deposit_array = _account.deposits;

			var deposit = new Money.Model.Action();
			deposit.timestamp = new DateTime.now_local().to_unix();
			deposit.balance_id = balance_id;
			deposit.amount = amount;
			deposit.description = description;
			
			deposit_array += deposit;
			_account.deposits = deposit_array;
		}

		public override void balance_withdraw(uint balance_id, uint amount, string description) {
			var withdrawal_array = _account.withdrawals;

			var withdrawal = new Money.Model.Action();
			withdrawal.timestamp = new DateTime.now_local().to_unix();
			withdrawal.balance_id = balance_id;
			withdrawal.amount = amount;
			withdrawal.description = description;

			withdrawal_array += withdrawal;
			_account.withdrawals = withdrawal_array;
		}

		public override uint add_balance(string name) {
			var balance = new Money.Model.Balance();
			balance.id = _account.next_balance_id++;
			balance.name = name;
			balance.deposit_weight = 0;
			balance.withdraw_weight = 0;

			var balances = _account.balances;
			balances += balance;
			_account.balances = balances;

			return balance.id;
		}

		public override void set_balance_deposit_weight(uint balance_id, int deposit_weight) {
			foreach(var balance in _account.balances) {
				if(balance.id == balance_id) {
					balance.deposit_weight = deposit_weight;
					return;
				}
			}
		}

		public override void set_balance_withdraw_weight(uint balance_id, int withdraw_weight) {
			foreach(var balance in _account.balances) {
				if(balance.id == balance_id) {
					balance.withdraw_weight = withdraw_weight;
					return;
				}
			}
		}

		public override void set_balance_name(uint balance_id, string name) {
			if (balance_id == 0) {
				_account.name = name;
				return;
			}
			foreach(var balance in _account.balances) {
				if(balance.id == balance_id) {
					balance.name = name;
					return;
				}
			}
		}

	}

}