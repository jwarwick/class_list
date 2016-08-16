# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ClassList.Repo.insert!(%ClassList.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
ClassList.Repo.delete_all ClassList.User

ClassList.User.changeset(%ClassList.User{}, %{name: "Test User", email: "test@example.com", password: "secret", password_confirmation: "secret"})
|> ClassList.Repo.insert!
