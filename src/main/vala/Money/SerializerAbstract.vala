

namespace Money.Model {
	public abstract class Serializer : GLib.Object {

		/***
		 * Turn the account into a string.
		 * @param account The account that you wish to serialize.
		 * @return The account that has been serialized.
		 */
		public abstract string serialize(Money.Model.Account account);

		/***
		 * Take a serialized account and make it useable
		 * @param account The account that is serialize.
		 * @return The account that has been deserialized.
		 */
		public abstract Money.Model.Account deserialize(string serialized_account);
		
	}
}