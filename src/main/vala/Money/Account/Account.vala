
namespace Money.Account {

	/**
	 * Accounts have a balance and listeners.
	 * The balance is how much is in the account.
	 * The listeners listen for a specific action, and respond.
	 */
	class Account : Object {
		private Money.Balance.Balance[] _balances;
		private Gee.HashMap<Money.Action.Actions, Money.Handler.BaseHandler> _handlers;

		public Account(Monet.Balance.Balance[] balances, Gee.HashMap<Money.Action.Actions, Money.Handler.BaseHandler> handlers) {
			_balances = balances;
			_handlers = handlers;
		}

		public Account.defaults() {
			this(new Money.Balance.Balance[4], new Gee.HashMap<Money.Action.Actions, Money.Handler.BaseHandler>());
		}

		public void add_balance(Money.Balance.Balance balance) {
			_balances += balance;
		}

		public void set_handler(Money.Action.Actions type, Money.Handler.BaseHandler handler) {
			_handlers[type] = handler;
		}

		public void do_action(Money.Action.Actions action, int64 amount) {
			print(@"Account.do_action($(action.name()), $amount)\n");
			if(_handlers.has_key(action)) {
				_handlers[action].on_action(amount);
			}
		}
	}
}