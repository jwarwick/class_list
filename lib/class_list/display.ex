defmodule ClassList.Display do
  @moduledoc """
  Helper functions to format strings for display
  """

  @doc """
  Format a name, handling `nil`
  """
  def format_name(nil), do: ""
  def format_name(str) do
    String.trim(str)
  end

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

  @doc """
  Format the city/state/zip line of the address
  """
  def format_city_address(city, state, zip) do
    {has_city, city} = fix_string(city)
    {has_state, state} = fix_string(state)
    state = format_state(state)
    {_has_zip, zip} = fix_string(zip)
    
    comma = if (has_city && has_state) do
      ", "
    else
      ""
    end

    "#{city}#{comma}#{state}  #{zip}"
  end

  # returns {string_has_content_boolean?, string_value ("" if has_content is false}
  defp fix_string(nil), do: {false, ""}
  defp fix_string(str) do
    str = String.trim(str)
    {0 != String.length(str), str}
  end

  # defp not_empty(nil), do: false
  # defp not_empty(str) do
  #   length = str |> String.trim |> String.length
  #   0 != length
  # end
end
