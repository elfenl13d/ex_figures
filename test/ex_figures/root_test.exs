defmodule ExFigures.RootTests do
  use ExFigures.ClientCase, async: true

  test "root calls api path" do
    mock fn
      %{method: :get, url: @base_url <> "/"} ->
        %Tesla.Env{status: 200, body: %{}}
    end

    assert {:ok, %Tesla.Env{} = env} = ExFigures.Root.get(client())
    assert env.status == 200
  end
end
