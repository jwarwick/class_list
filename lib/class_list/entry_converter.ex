defmodule ClassList.EntryConverter do
  @moduledoc """
  Convert raw input captured from an EntryController into
  a set of underlying models
  """

  alias ClassList.Student
  alias ClassList.Address
  alias ClassList.Parent
  alias ClassList.Repo

  @doc """
  Convert a map of params to models inserted into the repo
  """
  def convert(params) do
    students =
      params["student"]
      |> build_student_changesets(params["notes"])
      |> insert_student_changes()

    addresses =
      params["parent"]
      |> build_address_changesets()
      |> insert_address_changes()

    parents =
      params["parent"]
      |> build_parent_changesets(addresses, students)
      |> insert_parent_changes()

    {students, addresses, parents}
  end

  defp build_student_changesets(students, notes) do
    students
    |> Map.values
    |> Enum.filter(&non_empty_names/1)
    |> Enum.map(&(Map.put(&1, "notes", notes)))
    |> Enum.map(&(Student.entry_changeset(%Student{}, &1)))
  end

  def non_empty_names(%{"first_name" => first, "last_name" => last}) do
    (String.first(first) != nil) || (String.first(last) != nil)
  end

  defp insert_student_changes(students), do: Enum.map(students, &Repo.insert(&1))

  defp build_address_changesets(parents) do
    parents
    |> Map.values
    |> Enum.map(&maybe_add_address_changeset/1)
  end

  # don't add a changeset if the address is marked as
  # "same address as previous parent"
  defp maybe_add_address_changeset(%{"same-address" => "1"}) do
    nil
  end
  defp maybe_add_address_changeset(params) do
    Address.entry_changeset(%Address{}, params)
  end

  defp insert_address_changes(addresses) do
    addresses
    |> Enum.map(&insert_address_change/1)
    |> Enum.scan(&duplicate_if_nil(&1, &2))
  end

  defp insert_address_change(nil), do: nil
  defp insert_address_change(address), do: Repo.insert(address)

  defp duplicate_if_nil(nil, acc), do: acc
  defp duplicate_if_nil(val, _acc), do: val

  defp build_parent_changesets(parents, addresses, students) do
    address_ids = Enum.map(addresses,
        fn {:ok, %Address{id: id}} -> Integer.to_string(id) end)
    student_ids = Enum.map(students,
        fn {:ok, %Student{id: id}} -> Integer.to_string(id) end)

    parents
    |> Map.values
    |> Enum.filter(&non_empty_names/1)
    |> Enum.zip(address_ids)
    |> Enum.map(&(Parent.entry_changeset(%Parent{}, &1, student_ids)))
  end

  defp insert_parent_changes(changes), do: Enum.map(changes, &(Repo.insert(&1)))

end
