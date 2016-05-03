defmodule AnyoneImportant.Repo.Migrations.AddLastEmailSentAt do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :last_email_sent_at, :datetime, default: nil
    end
  end
end
