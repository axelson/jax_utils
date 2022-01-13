defmodule JaxUtils.StringHelpers do
  @doc """
  Check if a string is the empty string or nil

      iex> is_blank("")
      true

      iex> is_blank(nil)
      true

      iex> is_blank(" ")
      false

      iex> is_blank("I am that I am")
      false
  """
  defguard is_blank(value) when value == nil or value == ""
end
