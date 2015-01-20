

namespace Money {
	
	public const string COMMAND_NAME_HELP = "help";

	public const string COMMAND_NAME_VIEW = "view";
	public const string COMMAND_NAME_DEPOSIT = "deposit";
	public const string COMMAND_NAME_WITHDRAW = "withdraw";
	public const string COMMAND_NAME_SET_NAME = "set-name";

	public const string COMMAND_NAME_BALANCE = "balance";
	public const string COMMAND_NAME_BALANCE_VIEW = COMMAND_NAME_BALANCE + "-view";
	public const string COMMAND_NAME_BALANCE_DEPOSIT = COMMAND_NAME_BALANCE + "-" + COMMAND_NAME_DEPOSIT;
	public const string COMMAND_NAME_BALANCE_WITHDRAW = COMMAND_NAME_BALANCE + "-" + COMMAND_NAME_WITHDRAW;
	public const string COMMAND_NAME_BALANCE_SET_NAME = COMMAND_NAME_BALANCE + "-" + COMMAND_NAME_SET_NAME;
	public const string COMMAND_NAME_BALANCE_ADD = COMMAND_NAME_BALANCE + "-add";
	public const string COMMAND_NAME_BALANCE_SET_DEPOSIT_WEIGHT = COMMAND_NAME_BALANCE + "-" + COMMAND_NAME_DEPOSIT + "-weight";
	public const string COMMAND_NAME_BALANCE_SET_WITHDRAW_WEIGHT = COMMAND_NAME_BALANCE + "-" + COMMAND_NAME_WITHDRAW + "-weight";

	public enum Command {
		HELP,

		VIEW,
		DEPOSIT,
		WITHDRAW,
		SET_NAME,

		BALANCE_VIEW, // Sub domain balance
		BALANCE_DEPOSIT,
		BALANCE_WITHDRAW,
		BALANCE_SET_NAME,
		BALANCE_ADD,
		BALANCE_SET_DEPOSIT_WEIGHT,
		BALANCE_SET_WITHDRAW_WEIGHT,

		N_COMMANDS; // Shouldn't be used

		public string to_string() {
			switch(this) {
				case HELP: return COMMAND_NAME_HELP;
				case VIEW: return COMMAND_NAME_VIEW;
				case DEPOSIT: return COMMAND_NAME_DEPOSIT;
				case WITHDRAW: return COMMAND_NAME_WITHDRAW;

				case BALANCE_VIEW: return COMMAND_NAME_BALANCE_VIEW;
				case BALANCE_DEPOSIT: return COMMAND_NAME_BALANCE_DEPOSIT;
				case BALANCE_WITHDRAW: return COMMAND_NAME_BALANCE_WITHDRAW;
				case BALANCE_SET_NAME: return COMMAND_NAME_BALANCE_SET_NAME;
				case BALANCE_ADD: return COMMAND_NAME_BALANCE_ADD;
				case BALANCE_SET_DEPOSIT_WEIGHT: return COMMAND_NAME_BALANCE_SET_DEPOSIT_WEIGHT;
				case BALANCE_SET_WITHDRAW_WEIGHT: return COMMAND_NAME_BALANCE_SET_WITHDRAW_WEIGHT;

				default: return "help";
			}
		}

		public Param[] get_parameters() {
			switch(this) {
				case HELP: return {};
				case VIEW: return {};
				case DEPOSIT: return {Param.AMOUNT,Param.OPT_STRING};
				case WITHDRAW: return {Param.AMOUNT,Param.OPT_STRING};

				case BALANCE_VIEW: return {Param.BALANCE};
				case BALANCE_DEPOSIT: return {Param.BALANCE, Param.AMOUNT, Param.OPT_STRING};
				case BALANCE_WITHDRAW: return {Param.BALANCE, Param.AMOUNT, Param.OPT_STRING};
				case BALANCE_SET_NAME: return {Param.BALANCE, Param.STRING};
				case BALANCE_ADD: return {Param.STRING};
				case BALANCE_SET_DEPOSIT_WEIGHT: return {Param.BALANCE, Param.AMOUNT};
				case BALANCE_SET_WITHDRAW_WEIGHT: return {Param.BALANCE, Param.AMOUNT};

				default: return {};
			}
		}
	}

	public Command get_command(string command) {
		switch(command) {
			case COMMAND_NAME_HELP: return Command.HELP;

			case COMMAND_NAME_VIEW: return Command.VIEW;
			case COMMAND_NAME_DEPOSIT: return Command.DEPOSIT;
			case COMMAND_NAME_WITHDRAW: return Command.WITHDRAW;
			case COMMAND_NAME_SET_NAME: return Command.SET_NAME;

			case COMMAND_NAME_BALANCE_VIEW: return Command.BALANCE_VIEW;
			case COMMAND_NAME_BALANCE_DEPOSIT: return Command.BALANCE_DEPOSIT;
			case COMMAND_NAME_BALANCE_WITHDRAW: return Command.BALANCE_WITHDRAW;
			case COMMAND_NAME_BALANCE_SET_NAME: return Command.BALANCE_SET_NAME;
			case COMMAND_NAME_BALANCE_ADD: return Command.BALANCE_ADD;
			case COMMAND_NAME_BALANCE_SET_DEPOSIT_WEIGHT: return Command.BALANCE_SET_DEPOSIT_WEIGHT;
			case COMMAND_NAME_BALANCE_SET_WITHDRAW_WEIGHT: return Command.BALANCE_SET_WITHDRAW_WEIGHT;

			default: return Command.N_COMMANDS;
		}
		/* var klass = (EnumClass) typeof(Command) .class_ref();
		return (Command) klass.get_value_by_nick(command.down()); */
	}

	public enum Param {
		BALANCE,
		STRING,
		AMOUNT,
		OPT_STRING;

		public bool valid(string? arg, Money.View.Renderer view) {
			switch(this) {
				case BALANCE: return view.balance_exists(arg);
				case STRING: return arg!=null;
				case AMOUNT: return int64.try_parse(arg);
				case OPT_STRING: return true;
				default: return false;
			}
		}

		public string to_string() {
			switch(this) {
				case BALANCE: return "<balance>";
				case STRING: return "<string>";
				case AMOUNT: return "<amount>";
				case OPT_STRING: return "[string]";
				default: return "";
			}
		}
	}

	public bool validate(Param[] format, string[] args, Money.View.Renderer view) {
		for(var i=0; i<format.length; i++) {
			var f = format[i];
			var arg = i<args.length ? args[i] : null;
			if(!f.valid(arg, view)) return false;
		}
		return true;
	}

	/***
	 * Expand array until it is at least this size.
	 */
	public string[] expand(string[] array, int size) {
		if(size <= array.length) return array;
		var new_array = new string[size];
		for(var i=0; i<size; i++) {
			if(i<array.length) {
				new_array[i] = array[i];
			} else {
				new_array[i] = "";
			}
		}
		return new_array;
	}
}