

namespace Money.JSON {
	namespace Account {
		const string BALANCES_NAME = "balances";
		const string HANDLERS_NAME = "handlers";

		public void to_json(Json.Builder builder, Money.Account.Account account) {}

		public Money.Account.Account from_json(Json.Reader reader) {
			var balances = new Money.Balance.Balance[0];
			var handlers = new Gee.Hashmap<Money.Action.Actions, Money.Handler.BaseHandler>();

			foreach(var member in reader.list_members()) {
				reader.read_member(member);
				switch(member) {
					case BALANCES_NAME:
						for(var i=0; i<reader.count_elements(); i++) {
							balances += Money.JSON.Balance.from_json(reader);
						}
						break;
					case HANDLERS_NAME:
						foreach(var handler_type in reader.list_members()) {
							reader.read_member(handler_type);
							switch(type) {
								case Money.Action.Type.Deposit:
									handlers += Money.JSON.Handler.BasicHandler.from_json(reader);
									break;
								case Money.Action.Type.WeightedSplitter:
									handlers += Money.JSON.Handler.WeightedSplitter.from_json(reader);
									break;
								default:
									break;///NOTE HOW IT WASN"T MADE!
							}
							reader.end_member();
						}
						break;
				}
				reader.end_member();
			} 

			return new Money.Account.Account(balances, handlers);
		}
	}
}