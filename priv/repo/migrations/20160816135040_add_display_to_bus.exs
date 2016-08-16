defmodule ClassList.Repo.Migrations.AddDisplayToBus do
  use Ecto.Migration

  def change do
    alter table(:buses) do
      add :should_display, :boolean
    end
  end
end
