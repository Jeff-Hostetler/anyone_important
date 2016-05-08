defmodule AnyoneImportant.User do
  use AnyoneImportant.Web, :model
  use Timex
  require Ecto.Queryable

  schema "users" do
    field :name, :string
    field :email, :string
    field :last_email_sent_at, Timex.Ecto.DateTime
  end

  @required_fields ~w(name email)
  @optional_fields ~w(last_email_sent_at)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
