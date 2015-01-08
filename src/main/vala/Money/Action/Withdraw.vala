

namespace Money.Action {
	class Withdraw : BaseAction { // Widthdraw an amount

		private int64 amount;

		public Withdraw(int64 timestamp, string description, int64 amount) {
			base(timestamp, description);
			this.amount = amount;
		}

		public override int64 apply(int64 input_amount) {
			return input_amount - amount;
		}

		public override Money.Action.Actions action_type {
			get {return Money.Action.Actions.WITHDRAW;}
		}

	}
}