

namespace Money.Controller {
	public abstract class Controller : GLib.Object {

		public abstract Money.Model.Account model {get; set;}
		public abstract Money.View.Renderer view {get; set;}

		/***
		 * Makes a deposit in a balance.
		 * @param balance_id: The id of balance, or 0 for the account
		 * @param amount: The amount. To add a negative number, use a withdrawal.
		 * @param description: Why this deposit was made/where it came from.
		 */
		public abstract void balance_deposit(uint balance_id, uint amount, string description);
		
		/***
		 * Makes a withdrawal in a balance.
		 * @param balance_id: The id of balance, or 0 for the account
		 * @param amount: The amount. To add a negative number, use a deposit.
		 * @param description: Why this withdrawal was made.
		 */
		public abstract void balance_withdraw(uint balance_id, uint amount, string description);

		/***
		 * Create a new balance with the name.
		 * @param balance_name The name of the balance
		 * @return The id of the balance.
		 */
		public abstract uint add_balance(string balance_name);

		 /***
		  * Set the deposit weight of a balance.
		  * @param balance_id The id of the balance.
		  * @param deposit_weight The deposit weight of the balance.
		  */
		public abstract void set_balance_deposit_weight(uint balance_id, int deposit_weight);

		 /***
		  * Set the withdraw weight of a balance.
		  * @param balance_id The id of the balance.
		  * @param deposit_weight The withdraw weight of the balance.
		  */
		public abstract void set_balance_withdraw_weight(uint balance_id, int withdraw_weight);

		 /***
		  * Set the balance's name.
		  */
		 public abstract void set_balance_name(uint balance_id, string name);
	}

}