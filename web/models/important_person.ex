defmodule AnyoneImportant.ImportantPerson do
  use AnyoneImportant.Web, :model
  require Ecto.Queryable

  schema "important_persons" do
    field :handle, :string
  end

  @required_fields ~w(handle)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
