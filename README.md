# ExFigures

Elixir wrapper for Appfigures API based on [Tesla](https://github.com/teamon/tesla) library.

Appfigures provides a RESTful way to interact with reports and account data.
[More about API](https://docs.appfigures.com).

## Client Usage Example

Setup `ExFigures` client:

```elixir
client = ExFigures.client(
  username: "username",
  password: "password",
  client_key: "key"
)
```

And proceed to querying:

```elixir
{:ok, response} = ExFigures.Products.list_mine(client)
response.status # => 200
response.body # => [%{...}, ...]
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_figures` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_figures, "~> 0.1.0"}
  ]
end
```

## Documentation
Documentation be found at [https://hexdocs.pm/ex_figures](https://hexdocs.pm/ex_figures).
