# ExFigures 
[![Hex pm](http://img.shields.io/hexpm/v/ex_figures.svg?style=flat)](https://hex.pm/packages/ex_figures)
[![Hex pm](http://img.shields.io/hexpm/l/ex_figures.svg?style=flat)](https://hex.pm/packages/ex_figures)

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

## Resources
- [x] [/](https://docs.appfigures.com/api/reference/v2/root)
- [x] [/products](https://docs.appfigures.com/api/reference/v2/products)
- [ ] [/reports/sales](https://docs.appfigures.com/api/reference/v2/sales)
- [ ] [/reports/revenue](https://docs.appfigures.com/api/reference/v2/revenue)
- [ ] [/reports/subscriptions](https://docs.appfigures.com/api/reference/v2/subscriptions)
- [ ] [/reports/ads](https://docs.appfigures.com/api/reference/v2/ads)
- [ ] [/reports/adspend](https://docs.appfigures.com/api/reference/v2/ad-spend)
- [ ] [/reports/ratings](https://docs.appfigures.com/api/reference/v2/reports-ratings)
- [ ] [/reports/usage](https://docs.appfigures.com/api/reference/v2/reports/usage)
- [ ] [/ranks](https://docs.appfigures.com/api/reference/v2/ranks)
- [ ] [/featured](https://docs.appfigures.com/api/reference/v2/featured)
- [ ] [/reviews](https://docs.appfigures.com/api/reference/v2/reviews)
- [ ] [/events](https://docs.appfigures.com/api/reference/v2/events)
- [ ] [/archive](https://docs.appfigures.com/api/reference/v2/archive)
- [ ] [/users](https://docs.appfigures.com/api/reference/v2/users)
- [ ] [/external_accounts](https://docs.appfigures.com/api/reference/v2/external-accounts)
- [ ] [/data](https://docs.appfigures.com/api/reference/v2/data)
- [ ] [/usage](https://docs.appfigures.com/api/reference/v2/usage)

