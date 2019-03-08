use Mix.Config

config :logger, :console,
  level: :debug,
  format: "$date $time [$level] $metadata$message\n"

if File.exists?("config/dev.secret.exs") do
  import_config "dev.secret.exs"
end
