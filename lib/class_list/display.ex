defmodule ClassList.Display do
  @moduledoc """
  Helper functions to format strings for display
  """

  @doc """
  Format a telephone number
  """
  def format_phone(str) do
    numbers = String.replace(str, ~r/[^0-9]/, "")
    case String.length(numbers) do
      10 -> clean_phone(numbers)
      _ -> str
    end
  end

  defp clean_phone(numbers) do
    {area, rest} = String.split_at(numbers, 3)
    {prefix, suffix} = String.split_at(rest, 3)
    Enum.join([area, prefix, suffix], "-")
  end

end
