

namespace Money {

	public const string DEFAULT_DATA_DIR = ".money";
	public const string DEFAULT_DATA_FILE = "account.json";

	public void main(string[] args) {
		var f = "";
		if(args.length>1) f = args[1];
		var command = get_command(f);
		switch(command) {
			case Command.HELP:
				var klass = (EnumClass) typeof(Command) .class_ref();
				for (int i = 0; i < klass.n_values; i++) {
					var enum_value = klass.get_value(i);
					if (enum_value!=null) {
						print(enum_value.value_nick);
						print("\n");
					}
				}
				break;
			case Command.N_COMMANDS:
				print(@"Unknown command. Type \"$(args[0]) help\" for help.\n");
				break;
			default:
				var cmd_args = args[2:args.length];

				var home = GLib.Environment.get_home_dir();
				var file = home + "/" + DEFAULT_DATA_DIR + "/" + DEFAULT_DATA_FILE;
				do_command(file, command, cmd_args);
				break;
		}
	}

	public void do_command(string filepath, Command command, string[] cmd_args) {
		ensure_file(filepath);
		string data;
		FileUtils.get_contents(filepath, out data);

		var serializer = new Money.Model.JsonSerializer();
		var model = serializer.deserialize(data);

		var view = new Money.View.RendererImpl();
		view.model = model;

		var controller = new Money.Controller.BasicController();
		controller.model = model;
		controller.view = view;


		var format = command.get_parameters();
		if (!validate(format, cmd_args, view)) {
			print(@"Invalid command.\n");
			print(@"$(command.to_string()) ");
			foreach(var param in format) {
				print(@"$(param.to_string()) ");
			}
			print("\n");
			return;
		}
		var args = expand(cmd_args, format.length);


		switch(command) {
			case Command.VIEW: {
				print(view.render_account());
			} break;
			case Command.DEPOSIT: {
				if(ensure_weights(view)) { 
					controller.balance_deposit(0, (uint) int64.parse(args[0]), args[1]);
				}
			} break;
			case Command.WITHDRAW: {
				if(ensure_weights(view)) { 
					controller.balance_withdraw(0, (uint) int64.parse(args[0]), args[1]);
				}
			} break;
			case Command.SET_NAME: {
				controller.set_balance_name(0, args[0]);
				print(view.render_balance(0));
			} break;
			case Command.BALANCE_DEPOSIT: {
				var balance_id = view.get_balance_id(args[0]);
				var amount = (int) int64.parse(args[1]);
				controller.balance_deposit(balance_id, amount, args[2]);
			} break;
			case Command.BALANCE_WITHDRAW: {
				var balance_id = view.get_balance_id(args[0]);
				var amount = (int) int64.parse(args[1]);
				controller.balance_withdraw(balance_id, amount, args[2]);
			} break;
			case Command.BALANCE_SET_NAME: {
				var balance_id = view.get_balance_id(args[0]);
				controller.set_balance_name(balance_id, args[1]);
				print(view.render_balance(balance_id));
			} break;
			case Command.BALANCE_ADD: {
				controller.add_balance(args[0]);
			} break;
			case Command.BALANCE_SET_DEPOSIT_WEIGHT: {
				var balance_id = view.get_balance_id(args[0]);
				var amount = (int) int64.parse(args[1]);
				controller.set_balance_deposit_weight(balance_id, amount);
			} break;
			case Command.BALANCE_SET_WITHDRAW_WEIGHT: {
				var balance_id = view.get_balance_id(args[0]);
				var amount = (int) int64.parse(args[1]);
				controller.set_balance_withdraw_weight(balance_id, amount);
			} break;
		}

		data = serializer.serialize(model);
		backup(filepath, data);
		FileUtils.set_contents(filepath, data);
	}

	public bool ensure_weights(Money.View.Renderer renderer) {
		var b = true;
		if (renderer.total_deposit_weight()==0) {
			print("You must first set the depoist weights to do this.\n");
			b = false;
		}
		if (renderer.total_withdrawal_weight()==0) {
			print("You must first set the withdrawal weights to do this.\n");
			b = false;
		}
		return b;
	}

	public void ensure_file(string filepath) {
		var file = File.new_for_path(filepath);
		var folder = file.get_parent();

		if(!folder.query_exists()) {
			folder.make_directory_with_parents();
		}
		if(!file.query_exists()) {
			var model = Money.Model.init_model();
			var serializer = new Money.Model.JsonSerializer();
			var data = serializer.serialize(model);

			FileUtils.set_contents(filepath, data);
		}
	}

	public void backup(string file, string data) {
		var f = File.new_for_path(file);
		var folder = f.get_parent();
		var name = f.get_basename();
		var timestamp = new DateTime.now_local().format("%F");
		var filepath = folder.get_child(@"$(name)_$(timestamp).json").get_path();
		FileUtils.set_contents(filepath, data);
	}

}