# JaxUtils

Notable utils:
- `JaxUtils.ConfigHelpersV2` - Make it easier to parse environment variables within `config/runtime.exs`
- `JaxUtils.StringHelpers.is_blank/1` - Rails-like check if a string is blank (`nil` or `""`)
- `JaxUtils.CachexUtils.cachex_fetch_with_ttl/4` - Fetch a value in Cachex with a fallback cache with a built-in ttl (to avoid a separate call)
  - Note: only available if cachex is installed

## Installation

This package can be installed by adding `jax_utils` to your list of dependencies
in `mix.exs`:

```elixir
def deps do
  [
    {:jax_utils, github: "axelson/jax_utils"},
  ]
end
```
