

namespace Money.Balance {
	public class Balance : Object {

		private Money.Action.BaseAction[] _actions;
		private string _name;

		public Balance(string name, Money.Action.BaseAction[] actions) {
			_actions = actions;
			_name = name;
		}

		public void apply_action(Money.Action.BaseAction action) {
			print(@"Balance.apply_action($(action.action_type))\n");
			_actions += action;
		}

		public int64 balance {
			get {
				int64 b = 0;
				foreach(var action in _actions) {
					b = action.apply(b);
				}
				return b;
			}
		}

		public string name {
			get {return _name;}
		}
	}
}