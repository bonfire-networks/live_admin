defmodule LiveAdmin.Session do
  use Ecto.Schema

  @type t() :: %__MODULE__{
          id: String.t(),
          prefix: String.t(),
          metadata: map()
        }

  @primary_key {:id, :string, autogenerate: false}
  embedded_schema do
    field(:prefix, :string)
    field(:metadata, :map, default: %{})
  end
end
