
public static void main() {
	//Initialize variables
	var my_account = new Money.Account.Account();
	var checking_balance = new Money.Balance.Balance("Checking", {});
	var tithing_balance = new Money.Balance.Balance("Tithing", {});
	var savings_balance = new Money.Balance.Balance("Savings", {});
	var deposit_handler = new Money.Handler.WeightedSplitter(Money.Action.Actions.DEPOSIT, {
		Money.Handler.BalanceWeight(tithing_balance,1),
		Money.Handler.BalanceWeight(savings_balance, 5),
		Money.Handler.BalanceWeight(checking_balance, 4)
	});
	var withdraw_handler = new Money.Handler.BasicHandler(Money.Action.Actions.WITHDRAW, checking_balance);

	// Add balances to account
	my_account.add_balance(checking_balance);
	my_account.add_balance(tithing_balance);
	my_account.add_balance(savings_balance);

	// Add handlers to account
	my_account.set_handler(Money.Action.Actions.DEPOSIT, deposit_handler);
	my_account.set_handler(Money.Action.Actions.WITHDRAW, withdraw_handler);

	my_account.do_action(Money.Action.Actions.DEPOSIT, 1000);
	my_account.do_action(Money.Action.Actions.DEPOSIT, 1200);
	my_account.do_action(Money.Action.Actions.DEPOSIT, 3500);
	my_account.do_action(Money.Action.Actions.WITHDRAW, 500);

	var balances = new Money.Balance.Balance[] {checking_balance, tithing_balance, savings_balance};
	print("Balance\t\t\t\tAmount\n");
	foreach(var b in balances)
		print(@"$(b.name)\t\t\t\t$(b.balance)\n");
}