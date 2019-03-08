defmodule ExFigures.TeslaHelpers do
  def middleware_args(client, middleware) do
    with {_middleware, _func, args} <- find_middleware(client, middleware) do
      args
    end
  end

  def find_middleware(client, middleware) do
    Enum.find(client.pre, fn
      {^middleware, _, _} -> true
      _middleware -> false
    end)
  end
end
