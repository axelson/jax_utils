defmodule JaxUtils.LoggerHelpers do
  require Logger

  def plog(term, opts \\ []) do
    label = Keyword.get(opts, :label)

    if label do
      Logger.warn("#{label}: #{inspect(term, pretty: true)}")
    else
      Logger.warn(inspect(term))
    end

    term
  end
end
