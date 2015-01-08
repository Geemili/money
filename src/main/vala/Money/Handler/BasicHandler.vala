

namespace Money.Handler {
	public class BasicHandler : Money.Handler.BaseHandler {

		private Money.Balance.Balance _target;
		
		public BasicHandler(Money.Action.Type.Type action, Money.Balance.Balance target) {
			base(action);
			_target = target;
		}

		public override void on_action(int64 amount) {
			var action_to_perform = action.new_action(amount);
			if(action_to_perform!=null) {
				_target.apply_action(action_to_perform);
			}
		}

		public Money.Balance.Balance target {
			get {return _target;}
		}

	}
}