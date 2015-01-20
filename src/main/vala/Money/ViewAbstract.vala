

namespace Money.View {
	public abstract class Renderer : GLib.Object
	{
		public abstract Money.Model.Account model {get; set;}

		// ************* Balance Stuff *************
		/***
		 * Returns whether or not a balance with this name exists.
		 * @param balance_name The name of the balance.
		 * @return True if the balance exists, false otherwise.
		 */
		public abstract bool balance_exists(string? balance_name);

		/***
		 * Returns the id of a balance.
		 * @param balance_name The name of the balance
		 * @return: The id of the balance, or 0 for no balance.
		 */
		public abstract uint get_balance_id(string? balance_name);

		/***
		 * Returns the name of a balance.
		 * @param balance_id The id of the balance.
		 * @return The name of the balance.
		 */
		public abstract string get_balance_name(uint balance_id);

		/***
		 * Returns the depositing weight of the balance.
		 * @param balance_id The id of the balance.
		 * @return The weight of the balance.
		 */
		public abstract int get_balance_deposit_weight(uint balance_id);

		/***
		 * Returns the withdrawal weight of the balance.
		 * @param balance_id The id of the balance.
		 * @return The weight of the balance.
		 */
		public abstract int get_balance_withdrawal_weight(uint balance_id);

		/***
		 * Calaculates the amount of money in a balance.
		 * @param balance_id: The id of a balance, or 0 for the account.
		 * @return: The balance in the account
		 */
		public abstract int64 calculate_balance(uint balance_id);

		/***
		 * Renders a balance
		 * @param balance_id The id of the balance
		 * @return The balance rendered in a human readable format
		 */
		public abstract string render_balance(uint balance);

		// ************* Account Stuff *************

		/***
		 * Returns the total deposit weight.
		 * @return The total weight
		 */
		public abstract int total_deposit_weight();

		/***
		 * Returns the total withdrawal weight.
		 * @return The total weight
		 */
		public abstract int total_withdrawal_weight();

		/***
		 * Returns a list of the names of all the balances in the account.
		 * @param account 
		 * @return 
		 */
		public abstract uint[] list_balances();

		/***
		 * Renders the entire account
		 * @return The account rendered in a human readable format.
		 */
		public abstract string render_account();
	}
}