defmodule ExFigures do
  @moduledoc """
  Elixir wrapper for Appfigures API based on [Tesla](https://github.com/teamon/tesla) library.

  Appfigures provides a RESTful way to interact with reports and account data.
  More info here https://docs.appfigures.com
  """

  require Logger

  @base_url "https://api.appfigures.com/v2"

  @type t :: Tesla.Client.t()
  @type result :: Tesla.Env.result()
  @type option ::
          {:username, binary | {:system, binary}}
          | {:password, binary | {:system, binary}}
          | {:client_key, binary | {:system, binary}}
          | {:middleware, [any()]}

  @doc """
  Creates ExFigures client. The options passed affect
  authorization and middleware extending.

  Options:
    * `username` - appfigures account's username or email address.
    In case of empty client uses `:ex_figures, :username` config variable.
    * `password` - appfigures account's password.
    In case of empty client uses `:ex_figures, :password` config variable.
    * `client_key` - appfigures api client key.
    In case of empty client uses `:ex_figures, :password` config variable.
    * `middleware` - list of additional Tesla middle.
    Useful for extending client with additional functionality like
    instrumentation or logging.
  """
  @spec client([option]) :: ExFigures.t()
  def client(opts \\ []) do
    username = config_value(opts, :username)
    password = config_value(opts, :password)
    client_key = config_value(opts, :client_key)
    additional_middleware = Keyword.get(opts, :middleware, [])

    middleware = [
      {Tesla.Middleware.BaseUrl, @base_url},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.BasicAuth, %{username: username, password: password}},
      {Tesla.Middleware.Headers, [{"x-client-key", client_key}]}
    ]

    Tesla.client(middleware ++ additional_middleware)
  end

  @doc false
  defp config_value(opts, key) do
    value =
      opts
      |> Keyword.get_lazy(key, fn -> env(key) end)
      |> expand_value()

    ensure_value(key, value)
  end

  @doc false
  defp env(key) do
    Application.get_env(:ex_figures, key)
  end

  @doc false
  defp ensure_value(key, nil) do
    Logger.error(fn ->
      "ExFigures client can't be created because #{inspect(key)} in config is nil."
    end)
  end

  defp ensure_value(_key, value), do: value

  @doc false
  defp expand_value({:system, env_var}), do: expand_value(System.get_env(env_var))
  defp expand_value(value), do: value
end
