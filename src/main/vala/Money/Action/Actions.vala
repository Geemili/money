
namespace Money.Action {
	namespace Type {
		public const Type DEPOSIT = Type(
			"Money.Action.Deposit", (t,d,a)=>{return new Money.Action.Deposit(t, d, a);}
		);

		public const Type WITHDRAW = Type(
			"Money.Action.Withdraw", (t,d,a)=>{return new Money.Action.Deposit(t, d, a);}
		);

		delegate Money.Action.BaseAction Build(int64 time, string description, int64 amount);
		struct Type {
			public const string name;
			public const Build build;
			public Type(string name, Build construct) {
				this.name = name;
			}
		}
	}
	public Money.Action.BaseAction? new_action(string type, int64 amount) {
		var now = new DateTime.now_local().to_unix();
		var description = "";
		switch(type) {
			case Type.DEPOSIT:
				return new Money.Action.Deposit(now, description, amount);
			case Type.WITHDRAW:
				return new Money.Action.Withdraw(now, description, amount);
		}
		return null;
	}
}