

namespace Money.Action {
	/* namespace Action {
		public Money.Action.BaseAction? load_from_json(Json.Reader reader) {
			reader.read_member("type");
			var type = reader.get_string_value();
			reader.end_member();
			if (reader.get_null_value() && !reader.is_value())
				return null;

			switch(type) {
				case "Money.Action.Deposit":
					return new Money.Action.Deposit.from_json(reader);
				case "Money.Action.Withdraw":
					return new Money.Action.Withdraw.from_json(reader);
				default:
					return null;
			}
		}
	} */

	public abstract class BaseAction : Object {

		private int64 _timestamp;
		private string _description;
		public BaseAction(int64 timestamp, string description) {
			_timestamp = timestamp;
			_description = description;
		}

		public BaseAction.defaults() {
			_timestamp = new DateTime.now_local().to_unix();
			_description = "";
		}

		public int64 timestamp {
			get { return _timestamp; }
		}
		public string description {
			get { return _description; }
			set { _description = value; }
		}

		/**
		 * This function takes an amount that represents cents, and
		 * returns the amount after an action has been applied.
		 * @return: the balance after the action has been applied.
		 * @param input_amount: the initial amount before the action is applied
		 */
		public abstract int64 apply(int64 input_amount);

		public abstract Money.Action.Actions action_type {get;}
	}
}