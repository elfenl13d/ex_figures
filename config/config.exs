# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :tesla, adapter: Tesla.Adapter.Hackney

if Enum.member?([:test, :dev], Mix.env()) do
  import_config "#{Mix.env()}.exs"
end
