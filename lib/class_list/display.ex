defmodule ClassList.Display do
  @moduledoc """
  Helper functions to format strings for display
  """

  @doc """
  Format a telephone number
  """
  def format_phone(str) do
    numbers = str |> String.replace(~r/[^0-9]/, "") |> String.trim_leading("1")
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

  @doc """
  Format state name
  """
  def format_state(str) do
    state = String.replace(str, ~r/[^A-Za-z]/, "")
    case String.length(state) do
      2 -> String.upcase(state)
      _ -> str
    end
  end

end
