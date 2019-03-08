use Mix.Config

config :logger, :console,
  level: :debug,
  format: "$date $time [$level] $metadata$message\n"

config :tesla, adapter: Tesla.Mock
