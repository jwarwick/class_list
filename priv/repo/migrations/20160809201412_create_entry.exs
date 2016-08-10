defmodule ClassList.Repo.Migrations.CreateEntry do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :data, :text

      timestamps()
    end

  end
end
