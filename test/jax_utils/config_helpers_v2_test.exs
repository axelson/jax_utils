defmodule JaxUtils.ConfigHelpersV2Test do
  use ExUnit.Case, async: true
  use Machete

  alias JaxUtils.ConfigHelpersV2

  test "do_get_env/3 for a string when the env var is set" do
    val = "https://github.com"
    assert ConfigHelpersV2.do_get_env({:ok, val}, :string, :no_default) == val
  end

  test "do_get_env/3 for a string when the env var is not set but there is a default" do
    val = "https://github.com"
    assert ConfigHelpersV2.do_get_env(:error, :string, val) == val
  end

  test "do_get_env/3 for a string when the env var is not set and there is no default" do
    assert ConfigHelpersV2.do_get_env(:error, :string, :no_default) ==
             {:error, :not_found_and_no_default}
  end

  test "do_get_env/3 for an unknown type" do
    assert ConfigHelpersV2.do_get_env({:ok, "some val"}, :some_unsupported_type, :no_default) ==
             {:error, :unsupported_type}
  end

  test "do_get_env/3 for an integer when exists and can convert" do
    assert ConfigHelpersV2.do_get_env({:ok, "23"}, :integer, :no_default) == {:ok, 23}
  end

  test "do_get_env/3 for an integer that cannot be converted" do
    assert ConfigHelpersV2.do_get_env({:ok, "not an int"}, :integer, :no_default) ==
             {:error, "Invalid value for integer: \"not an int\""}
  end

  test "do_get_env/3 for a valid json" do
    assert ConfigHelpersV2.do_get_env({:ok, ~s[{"key": 42}]}, :json, :no_default) ==
             {:ok, %{"key" => 42}}
  end

  test "do_get_env/3 for an invalid json" do
    assert ConfigHelpersV2.do_get_env({:ok, "not json"}, :json, :no_default)
           ~> {:error, is_a(%Jason.DecodeError{})}
  end

  test "do_get_env/3 for a valid csv with multiple entries" do
    assert ConfigHelpersV2.do_get_env({:ok, "a,b"}, :csv, :no_default) ==
             {:ok, ["a", "b"]}
  end

  test "do_get_env/3 for a valid csv with one entry" do
    assert ConfigHelpersV2.do_get_env({:ok, "a"}, :csv, :no_default) ==
             {:ok, ["a"]}
  end

  test "do_get_env/3 for a valid csv with an empty string" do
    assert ConfigHelpersV2.do_get_env({:ok, ""}, :csv, :no_default) ==
             {:ok, []}
  end

  test "do_get_env/3 for a valid boolean \"true\"" do
    assert ConfigHelpersV2.do_get_env({:ok, "true"}, :boolean, :no_default) ==
             {:ok, true}
  end

  test "do_get_env/3 for a valid boolean \"false\"" do
    assert ConfigHelpersV2.do_get_env({:ok, "false"}, :boolean, :no_default) ==
             {:ok, false}
  end

  test "do_get_env/3 for a boolean with an invalid value" do
    assert ConfigHelpersV2.do_get_env({:ok, "not a valid boolean"}, :boolean, :no_default) ==
             {:error, "Invalid value for boolean: \"not a valid boolean\""}
  end

  test "do_get_env/3 for a boolean with empty string" do
    assert ConfigHelpersV2.do_get_env({:ok, ""}, :boolean, :no_default) ==
             {:error, "Invalid value for boolean: \"\""}
  end
end
