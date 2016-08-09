defmodule ClassList.Repo.Migrations.AddStudentsParents do
  use Ecto.Migration

  def change do
    create table(:parents_students, primary_key: false) do
      add :parent_id, references(:parents)
      add :student_id, references(:students)
    end
  end
end
