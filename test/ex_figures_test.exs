defmodule ExFigures.ExFiguresTest do
  use ExUnit.Case
  import ExFigures.TeslaHelpers

  describe "client" do
    @username "test_username"
    @password "test_password"
    @client_key "test_client_key"

    @plain_opts [
      username: @username,
      password: @password,
      client_key: @client_key
    ]

    @sys_opts [
      username: {:system, "EXFIGURES_USERNAME"},
      password: {:system, "EXFIGURES_PASSWORD"},
      client_key: {:system, "EXFIGURES_CLIENT_KEY"}
    ]

    @sys_env %{
      "EXFIGURES_USERNAME" => "test_username",
      "EXFIGURES_PASSWORD" => "test_password",
      "EXFIGURES_CLIENT_KEY" => "test_client_key"
    }

    test "uses plain variables from opts" do
      client = ExFigures.client(@plain_opts)

      assert_client_setup(client)
    end

    test "extropolates environment variables from opts" do
      setup_system_env(@sys_env)
      client = ExFigures.client(@sys_opts)

      assert_client_setup(client)
    end

    test "uses plain variables from config" do
      setup_app_env(@plain_opts)
      client = ExFigures.client()

      assert_client_setup(client)
    end

    test "extrapolates environment variables from config" do
      setup_system_env(@sys_env)
      setup_app_env(@sys_opts)

      client = ExFigures.client()
      assert_client_setup(client)
    end

    defp setup_system_env(env) do
      System.put_env(env)

      on_exit(fn ->
        env |> Map.keys() |> Enum.map(&System.delete_env/1)
      end)
    end

    defp setup_app_env(env) do
      Enum.map(env, fn {k, v} ->
        Application.put_env(:ex_figures, k, v)
      end)
    end

    defp assert_client_setup(client) do
      assert middleware_args(client, Tesla.Middleware.BasicAuth) == [
               %{password: "test_password", username: "test_username"}
             ]

      assert middleware_args(client, Tesla.Middleware.Headers) == [
               [{"x-client-key", "test_client_key"}]
             ]

      assert middleware_args(client, Tesla.Middleware.BaseUrl) == [
               "https://api.appfigures.com/v2"
             ]
    end
  end
end
