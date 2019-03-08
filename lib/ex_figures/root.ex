defmodule ExFigures.Root do
  @doc """
  The root resource provides basic information about the currently authenticated user.

  More info here https://docs.appfigures.com/api/reference/v2/root
  """
  @spec get(ExFigures.t()) :: ExFigures.result()
  def get(client) do
    Tesla.get(client, "/")
  end
end
