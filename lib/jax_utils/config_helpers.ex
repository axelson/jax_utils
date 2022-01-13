# Inspired by
# https://blog.nytsoi.net/2021/04/17/elixir-simple-configuration
defmodule JaxUtils.ConfigHelpers do
  @type config_type :: :string | :integer | :boolean | :json

  @doc """
  Get value from environment variable, converting it to the given type if needed.

  If no default value is given, or `:no_default` is given as the default, an error is raised if the variable is not
  set.
  """
  @spec get_env(String.t(), :no_default | any(), config_type()) :: any()
  def get_env(var, default \\ :no_default, type \\ :string)

  def get_env(var, :no_default, type) do
    System.fetch_env!(var)
    |> get_with_type(type)
  end

  def get_env(var, default, type) do
    with {:ok, val} <- System.fetch_env(var) do
      get_with_type(val, type)
    else
      :error -> default
    end
  end

  @spec get_with_type(String.t(), config_type()) :: any()
  defp get_with_type(val, type)

  defp get_with_type(val, :string), do: val
  defp get_with_type(val, :integer), do: String.to_integer(val)
  defp get_with_type("true", :boolean), do: true
  defp get_with_type("false", :boolean), do: false
  defp get_with_type(val, :json), do: Jason.decode!(val)
  defp get_with_type(val, :csv), do: csv_decode!(val)
  defp get_with_type(val, type), do: raise("Cannot convert to #{inspect(type)}: #{inspect(val)}")

  defp csv_decode!(val) do
    String.split(val, ",", trim: true)
    |> Enum.map(&String.trim/1)
  end
end
