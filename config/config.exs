# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :tesla, adapter: Tesla.Adapter.Hackney

if Mix.env() == :test do
  config :logger, :console,
    level: :debug,
    format: "$date $time [$level] $metadata$message\n"

  config :tesla, MockClient, adapter: Tesla.Mock
end
