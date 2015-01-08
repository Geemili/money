

namespace Money.Handler {
	
	public class WeightedSplitter : Money.Handler.BaseHandler {
		
		private BalanceWeight[] _weights;

		public WeightedSplitter(Money.Action.Actions action, BalanceWeight[] weights) {
			base(action);
			_weights = weights;
		}

		public override void on_action(int64 amount) {
			var amount_left = amount;
			int64 total_weight = 0;
			foreach(var bw in weights) {
				total_weight += bw.weight;
			}
			foreach(var bw in weights) {
				var b = amount * bw.weight / total_weight;
				if(b>amount_left) {
					b = amount_left;
				}

				var action_to_perform = action.new_action(b);
				bw.balance.apply_action(action_to_perform);

				amount_left -= b;
			}
		}

		public BalanceWeight[] weights {
			get {return _weights;}
		}
	}

	public struct BalanceWeight {
		public Money.Balance.Balance balance;
		public int64 weight;

		public BalanceWeight(Money.Balance.Balance balance, int64 weight) {
			this.balance = balance;
			this.weight = weight;
		}
	}

}