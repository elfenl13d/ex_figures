defmodule ExFigures.RootTests do
  use ExFigures.ClientCase, async: true

  test "root calls api path", %{client: client} do
    mock fn
      %{method: :get, url: @base_url <> "/"} ->
        %Tesla.Env{status: 200, body: %{}}
    end

    response = ExFigures.Root.get(client)
    assert client_response(response, 200)
  end
end
