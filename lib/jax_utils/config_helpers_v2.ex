defmodule JaxUtils.ConfigHelpersV2 do
  @type config_type :: :string | :integer | :boolean | :json | :csv

  @doc """
  Same as `get_env/3` but raises if the env var is not set
  """
  def get_env!(var, type) do
    get_env(var, type, :no_default)
  end

  @doc """
  Get value from environment variable, converting it to the given type if needed.

  Similar to JaxUtils.ConfigHelpers but receives the type before the default

  If no default value is given, or `:no_default` is given as the default, an error is raised if the variable is not
  set.

  Note: possible types are :string, :integer, :boolean, :json, :csv

  :csv only supports a very simple "csv" format that only looks for `,` (so it doesn't support values that have a `,` inside of them)
  """
  @spec get_env(String.t(), config_type(), :no_default | any()) :: any()
  def get_env(var, type \\ :string, default \\ :no_default)

  # def get_env(var, type, :no_default) do
  #   System.fetch_env!(var)
  #   |> get_with_type(type)
  # end

  # def get_env(var, type, default) when is_binary(var) do
  #   System.get_env(var, default)
  #   |> get_with_type(type)
  # end

  def get_env(var, type, default) when is_binary(var) do
    System.fetch_env(var)
    |> do_get_env(type, default)
    |> case do
      {:ok, value} ->
        value

      {:error, :not_found_and_no_default} ->
        raise "Environment Variable #{var} is required but was not defined"

      {:error, :unsupported_type} ->
        raise(
          "Error parsing environment variable #{var}. Type #{inspect(type)} is not a supported conversion type."
        )
    end
  end

  def do_get_env(env_var_result, type, default) do
    case {env_var_result, default} do
      {{:ok, val}, _default} -> get_with_type(val, type)
      {:error, :no_default} -> {:error, :not_found_and_no_default}
      {:error, default} -> get_with_type(default, type)
    end
  end

  # def do_get_env({:ok, val}, _var, type, default) do
  #   get_with_type(val, type)
  # end

  # def do_get_env(:error, _var, type, :no_default) do
  #   raise
  #   end

  # def do_get_env(:error, type, default) do
  #   default
  # end

  @spec get_with_type(String.t(), config_type()) :: any()
  defp get_with_type(val, type)

  defp get_with_type(val, :string), do: val

  defp get_with_type(val, :integer) do
    case Integer.parse(val, 10) do
      {int, ""} -> {:ok, int}
      _ -> {:error, "Invalid value for integer: \"#{val}\""}
    end
  end

  defp get_with_type(val, :boolean) do
    case val do
      "true" -> {:ok, true}
      "false" -> {:ok, false}
      _ -> {:error, "Invalid value for boolean: \"#{val}\""}
    end
  end

  defp get_with_type(val, :json), do: Jason.decode(val)
  defp get_with_type(val, :csv), do: csv_decode!(val)
  defp get_with_type(_val, _type), do: {:error, :unsupported_type}

  defp csv_decode!(val) do
    values =
      String.split(val, ",", trim: true)
      |> Enum.map(&String.trim/1)

    {:ok, values}
  end
end
