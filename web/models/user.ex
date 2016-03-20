defmodule AnyoneImportant.User do
  use AnyoneImportant.Web, :model
  require Ecto.Queryable

  schema "users" do
    field :name, :string
    field :email, :string
  end

  @required_fields ~w(name email)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end