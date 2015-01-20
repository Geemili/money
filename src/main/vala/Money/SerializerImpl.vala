

namespace Money.Model {
	public class JsonSerializer : Serializer {

		private Json.Parser parser;
		private Json.Generator generator;

		private const string ACCOUNT_NAME = "name";
		private const string ACCOUNT_BALANCES = "balances";
		private const string ACCOUNT_DEPOSITS = "deposits";
		private const string ACCOUNT_WITHDRAWALS = "withdrawals";
		private const string ACCOUNT_NEXT_BALANCE_ID = "next_balance_id";

		private const string BALANCE_ID = "id";
		private const string BALANCE_NAME = "name";
		private const string BALANCE_DEPOSIT_WEIGHT = "deposit_weight";
		private const string BALANCE_WITHDRAW_WEIGHT = "withdraw_weight";

		private const string ACTION_TIMESTAMP = "timestamp";
		private const string ACTION_BALANCE_ID = "balance_id";
		private const string ACTION_AMOUNT = "amount";
		private const string ACTION_DESCRIPTION = "description";

		public JsonSerializer() {
			parser = new Json.Parser();
			generator = new Json.Generator();
		}

		public override string serialize(Money.Model.Account account) {
			var builder = new Json.Builder();

			builder.begin_object();

			builder.set_member_name(ACCOUNT_NAME);
			builder.add_string_value(account.name);

			builder.set_member_name(ACCOUNT_NEXT_BALANCE_ID);
			builder.add_int_value((int64) account.next_balance_id);

			builder.set_member_name(ACCOUNT_BALANCES);
			builder.begin_array();
			foreach(var balance in account.balances) {
				builder.begin_object();

				builder.set_member_name(BALANCE_ID);
				builder.add_int_value((int64) balance.id);

				builder.set_member_name(BALANCE_NAME);
				builder.add_string_value(balance.name);

				builder.set_member_name(BALANCE_DEPOSIT_WEIGHT);
				builder.add_int_value((int64) balance.deposit_weight);

				builder.set_member_name(BALANCE_WITHDRAW_WEIGHT);
				builder.add_int_value((int64) balance.withdraw_weight);

				builder.end_object();
			}
			builder.end_array();

			builder.set_member_name(ACCOUNT_DEPOSITS);
			serialize_action_array(builder, account.deposits);

			builder.set_member_name(ACCOUNT_WITHDRAWALS);
			serialize_action_array(builder, account.withdrawals);

			builder.end_object();

			generator.set_root(builder.get_root());
			return generator.to_data(null);
		}

		private void serialize_action_array(Json.Builder builder, Money.Model.Action[] actions) {
			builder.begin_array();
			foreach(var action in actions) {
				builder.begin_object();

				builder.set_member_name(ACTION_TIMESTAMP);
				builder.add_int_value((int64) action.timestamp);

				builder.set_member_name(ACTION_BALANCE_ID);
				builder.add_int_value((int64) action.balance_id);

				builder.set_member_name(ACTION_AMOUNT);
				builder.add_int_value((int64) action.amount);

				builder.set_member_name(ACTION_DESCRIPTION);
				builder.add_string_value(action.description);

				builder.end_object();
			}
			builder.end_array();
		}

		public override Money.Model.Account deserialize(string serialized_account) {
			parser.load_from_data(serialized_account);
			var reader = new Json.Reader(parser.get_root());

			var account = new Account();
			foreach(var member in reader.list_members()) {
				reader.read_member(member);
				switch(member) {
					case ACCOUNT_NAME: {
						account.name = reader.get_string_value();
					} break;
					case ACCOUNT_BALANCES: {
						account.balances = new Balance[reader.count_elements()];
						for(var i=0; i<reader.count_elements(); i++) {
							reader.read_element(i);
							account.balances[i] = deserialize_balance(reader);
							reader.end_element();
						}
					} break;
					case ACCOUNT_WITHDRAWALS: {
						account.withdrawals = new Action[reader.count_elements()];
						for(var i=0; i<reader.count_elements(); i++) {
							reader.read_element(i);
							account.withdrawals[i] = deserialize_action(reader);
							reader.end_element();
						}
					} break;
					case ACCOUNT_DEPOSITS: {
						account.deposits = new Action[reader.count_elements()];
						for(var i=0; i<reader.count_elements(); i++) {
							reader.read_element(i);
							account.deposits[i] = deserialize_action(reader);
							reader.end_element();
						}
					} break;
					case ACCOUNT_NEXT_BALANCE_ID: {
						account.next_balance_id = (uint) reader.get_int_value();
					} break;
				}
				reader.end_member();
			}
			return account;
		}

		private Money.Model.Balance deserialize_balance(Json.Reader reader) {
			var balance = new Balance();
			foreach(var member in reader.list_members()) {
				reader.read_member(member);
				switch(member) {
					case BALANCE_ID: {
						balance.id = (uint) reader.get_int_value();
					} break;
					case BALANCE_NAME: {
						balance.name = reader.get_string_value();
					} break;
					case BALANCE_DEPOSIT_WEIGHT: {
						balance.deposit_weight = (int) reader.get_int_value();
					} break;
					case BALANCE_WITHDRAW_WEIGHT: {
						balance.withdraw_weight = (int) reader.get_int_value();
					} break;
				}
				reader.end_member();
			}
			return balance;
		}

		private Money.Model.Action deserialize_action(Json.Reader reader) {
			var action = new Action();
			foreach(var member in reader.list_members()) {
				reader.read_member(member);
				switch(member) {
					case ACTION_TIMESTAMP: {
						action.timestamp = reader.get_int_value();
					} break;
					case ACTION_BALANCE_ID: {
						action.balance_id = (uint) reader.get_int_value();
					} break;
					case ACTION_AMOUNT: {
						action.amount = (uint) reader.get_int_value();
					} break;
					case ACTION_DESCRIPTION: {
						action.description = reader.get_string_value();
					} break;
				}
				reader.end_member();
			}
			return action;
		}
		
	}
}