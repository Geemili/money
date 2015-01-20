
void test_money() {
	var model = Money.Model.init_model();
	model.name = "My Account";

	var view = new Money.View.RendererImpl();
	view.model = model;

	var control = new Money.Controller.BasicController();
	control.model = model;
	control.view = view;

	var checking = control.add_balance("Checking");
	control.set_balance_deposit_weight(checking, 4);
	control.set_balance_withdraw_weight(checking, 1);

	var savings = control.add_balance("Savings");
	control.set_balance_deposit_weight(savings, 5);
	control.set_balance_withdraw_weight(savings, 0);

	var tithing = control.add_balance("Tithing");
	control.set_balance_deposit_weight(tithing, 1);
	control.set_balance_withdraw_weight(tithing, 0);

	control.balance_deposit(0, 1000, "");
	control.balance_deposit(0, 10, "");
	control.balance_deposit(0, 24, "");
	control.balance_deposit(0, 36, "");
	control.balance_withdraw(0, 400, "");
	control.balance_withdraw(tithing, 106, "");

	var render = view.render_account();

	print(@"$(render)\n");
}