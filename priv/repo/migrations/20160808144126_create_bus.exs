defmodule ClassList.Repo.Migrations.CreateBus do
  use Ecto.Migration

  def change do
    create table(:buses) do
      add :name, :string
      add :order, :integer

      timestamps()
    end

  end
end
