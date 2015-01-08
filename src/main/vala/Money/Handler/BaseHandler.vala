

namespace Money.Handler {
	public abstract class BaseHandler : GLib.Object {

		private Money.Action.Type.Type _action_template;
		
		public BaseHandler(Money.Action.Type.Type action) {
			_action_template = action;
		}

		public abstract void on_action(int64 amount);

		public Money.Action.Actions action {
			get {return _action_template;}
		}

	}
}