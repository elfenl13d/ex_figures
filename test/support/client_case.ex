defmodule ExFigures.ClientCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Tesla.Mock

      @base_url "https://api.appfigures.com/v2"

      def client do
        ExFigures.client(
          username: "test_username",
          password: "test_password",
          client_key: "test_client_key"
        )
      end
    end
  end
end
