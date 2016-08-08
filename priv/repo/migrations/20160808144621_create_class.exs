defmodule ClassList.Repo.Migrations.CreateClass do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :name, :string
      add :teacher, :string
      add :order, :integer

      timestamps()
    end

  end
end
