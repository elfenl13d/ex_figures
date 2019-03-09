defmodule ExFigures.ClientCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Tesla.Mock

      @base_url "https://api.appfigures.com/v2"

      def mock_call(method, path, opts \\ []) do
        url = @base_url <> path
        response = %Tesla.Env{status: 200, body: %{}}
        query = Keyword.get(opts, :query, [])

        body =
          case Keyword.fetch(opts, :body) do
            {:ok, body} -> Jason.encode!(body)
            :error -> nil
          end

        mock fn
          %{method: ^method, url: ^url, query: ^query, body: ^body} ->
            response
        end
      end

      def client_response({:ok, %Tesla.Env{status: status} = env}, status) do
        env
      end
    end
  end

  def build_client() do
    ExFigures.client(
      username: "test_username",
      password: "test_password",
      client_key: "test_client_key"
    )
  end

  setup do
    {:ok, client: build_client()}
  end
end
