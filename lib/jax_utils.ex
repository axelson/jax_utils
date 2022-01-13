defmodule JaxUtils do
  defdelegate plog(term), to: JaxUtils.LoggerHelpers
  defdelegate plog(term, opts), to: JaxUtils.LoggerHelpers
end
