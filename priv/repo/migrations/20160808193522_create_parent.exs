defmodule ClassList.Repo.Migrations.CreateParent do
  use Ecto.Migration

  def change do
    create table(:parents) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :mobile_phone, :string
      add :address_id, references(:addresses, on_delete: :nothing)

      timestamps()
    end
    create index(:parents, [:address_id])

  end
end
