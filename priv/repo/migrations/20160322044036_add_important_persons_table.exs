defmodule AnyoneImportant.Repo.Migrations.AddImportantPersonsTable do
  use Ecto.Migration

  def change do
    create table(:important_persons) do
      add :handle, :string
    end
  end
end
