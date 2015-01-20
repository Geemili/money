

namespace Money.View {
	
	public const string ANSI_COLOR_RED = "\x1b[31m";
	public const string ANSI_COLOR_GREEN = "\x1b[32m";
	public const string ANSI_COLOR_YELLOW = "\x1b[33m";
	public const string ANSI_COLOR_RESET = "\x1b[0m";

	public class RendererImpl : Money.View.Renderer {

		private Money.Model.Account _account;


		public override Money.Model.Account model {
			get {return _account;}
			set {_account = value;}
		}

		public override bool balance_exists(string? balance_name) {
			foreach(var balance in _account.balances)
			{
				if(balance.name == balance_name)
				{
					return true;
				}
			}
			return false;
		}

		public override uint get_balance_id(string? balance_name) {
			foreach(var balance in _account.balances)
			{
				if(balance.name == balance_name)
				{
					return balance.id;
				}
			}
			return 0;
		}

		public override string get_balance_name(uint balance_id) {
			if(balance_id == 0) {
				return _account.name;
			}
			foreach(var balance in _account.balances) {
				if(balance.id == balance_id) {
					return balance.name;
				}
			}
			return "";
		}

		public override int get_balance_deposit_weight(uint balance_id) {
			foreach(var balance in _account.balances) {
				if(balance.id == balance_id) {
					return balance.deposit_weight;
				}
			}
			return 0;
		}

		public override int get_balance_withdrawal_weight(uint balance_id) {
			foreach(var balance in _account.balances) {
				if(balance.id == balance_id) {
					return balance.withdraw_weight;
				}
			}
			return 0;
		}

		public override int64 calculate_balance(uint balance_id) {
			int64 result = 0;
			var deposit_weight_total = total_deposit_weight();
			var withdraw_weight_total = total_withdrawal_weight();
			foreach(var deposit in _account.deposits) {
				if(deposit.balance_id == balance_id || balance_id == 0)
				{
					result += deposit.amount;
				} else if(deposit.balance_id == 0) {
					var weight = get_balance_deposit_weight(balance_id);
					result += deposit.amount * weight / deposit_weight_total;
				}
			}
			foreach(var withdrawal in _account.withdrawals) {
				if(withdrawal.balance_id == balance_id || balance_id == 0)
				{
					result -= withdrawal.amount;
				} else if(withdrawal.balance_id == 0) {
					var weight = get_balance_withdrawal_weight(balance_id);
					result -= withdrawal.amount * weight / withdraw_weight_total;
				}
			}
			return result;
		}

		/* public override Money.Model.Balance? get_balance(uint id) {
			foreach(var balance in account.balances)
			{
				if(balance.id == id)
				{
					return balance;
				}
			}
			return null;
		} */

		public override int total_deposit_weight() {
			var total_weight = 0;
			foreach(var balance in _account.balances)
			{
				total_weight += balance.deposit_weight;
			}
			return total_weight;
		}

		public override int total_withdrawal_weight() {
			var total_weight = 0;
			foreach(var balance in _account.balances)
			{
				total_weight += balance.withdraw_weight;
			}
			return total_weight;
		}

		public override string render_balance(uint balance_id) {
			var name = get_balance_name(balance_id);
			var balance = calculate_balance(balance_id);
			var color = balance < 0 ? ANSI_COLOR_RED : ANSI_COLOR_GREEN ;
			var reset = ANSI_COLOR_RESET;
			
			var builder = new GLib.StringBuilder();
			builder.append_printf(@"%*s$(color)%*s$(reset)\n", 25, name, 25, "$"+(balance/100f).to_string("%.2f"));
			return builder.str;
		}

		public override uint[] list_balances() {
			var balance_ids = new uint[0];
			balance_ids += 0;
			foreach(var balance in _account.balances) {
				balance_ids += balance.id;
			}
			return balance_ids;
		}

		public override string render_account() {
			var builder = new GLib.StringBuilder();
			var balances = list_balances();
			var b = false; // To help make only the first line yellow
			builder.append(ANSI_COLOR_YELLOW);
			foreach(var balance in balances) {
				builder.append(render_balance(balance));
				if(b) {
					builder.append(ANSI_COLOR_RESET);
				}
			}
			return builder.str;
		}
	}
}