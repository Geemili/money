
namespace Money.Action {
	class Deposit : BaseAction {
		private int64 _amount; // The amount of money being deposited

		public Deposit(int64 timestamp, string description, int64 amount) {
			base(timestamp, description);
			_amount = amount;
		}

		public override int64 apply(int64 input_amount) {
			return input_amount + _amount;
		}

		public override Money.Action.Actions action_type {
			get {return Money.Action.Actions.DEPOSIT;}
		}
	}
}