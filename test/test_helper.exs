ExUnit.start

Mix.Task.run "ecto.create", ~w(-r AnyoneImportant.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r AnyoneImportant.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(AnyoneImportant.Repo)

