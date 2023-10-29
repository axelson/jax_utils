if Code.ensure_loaded?(Cachex) do
  defmodule JaxUtils.CachexUtils do
    def cachex_fetch_with_ttl(cache, key, fallback, options, ttl) do
      # Helper function based on proposed implementation at:
      # https://github.com/whitfin/cachex/issues/195#issuecomment-422210432
      with {:commit, val} <- Cachex.fetch(cache, key, fallback, options) do
        Cachex.expire(cache, key, ttl)
        {:commit, val}
      end
      |> case do
        {:commit, val} -> {:ok, val}
        result -> result
      end
    end
  end
end
