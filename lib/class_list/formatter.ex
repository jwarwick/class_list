defmodule ClassList.Formatter do
  @moduledoc """
  Output the directory in an RTF format
  """
  require EEx
  import Ecto.Query
  alias ClassList.Class
  alias ClassList.Student
  alias ClassList.Repo
  
  EEx.function_from_file(:def, :directory, 
                         Path.expand("templates/directory.rtf.eex", __DIR__),
                         [:assigns])
  EEx.function_from_file(:def, :class, 
                         Path.expand("templates/class.rtf.eex", __DIR__),
                         [:assigns])
  EEx.function_from_file(:def, :student, 
                         Path.expand("templates/student.rtf.eex", __DIR__),
                         [:assigns])

  @doc """
  Generate the RTF string
  """
  def create do
    classes = 
      Class
      |> Class.sorted
      |> Repo.all
      |> Repo.preload([students: from(Student, order_by: [:last_name])])
      |> Repo.preload([students: [:bus, :class, [parents: :address]]])

    directory(classes: classes)
  end

  @doc """
  Generate RTF file
  """
  def write(path) do
    result = create()
    File.write(Path.expand(path), result)
  end

end
