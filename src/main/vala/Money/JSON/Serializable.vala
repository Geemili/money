

namespace Money.JSON {
	public interface Serializable {
		public void from_json(Json.Reader reader);
		public void to_json(Json.Builder builder)
	}

	public const string TYPE_NAME = "type";

	public Serializable? from_json() {}

}