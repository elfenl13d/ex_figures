defmodule ExFigures.ProductsTests do
  use ExFigures.ClientCase, async: true

  alias ExFigures.Products

  test "get_by_appfigures_id/2 calls api", %{client: client} do
    mock_call(:get, "/products/id")

    response = Products.get_by_appfigures_id(client, "id")
    assert client_response(response, 200)
  end

  test "get_by_store_id/3 calls api", %{client: client} do
    mock_call(:get, "/products/store/id")

    response = Products.get_by_store_id(client, "store", "id")
    assert client_response(response, 200)
  end

  describe "search/3" do
    test "calls api without query", %{client: client} do
      mock_call(:get, "/products/search/term")

      response = Products.search(client, "term")
      assert client_response(response, 200)
    end

    test "calls api with query", %{client: client} do
      mock_call(:get, "/products/search/term", query: [filter: "filter"])

      response = Products.search(client, "term", filter: "filter")
      assert client_response(response, 200)
    end
  end

  describe "list_mine/2" do
    test "calls api without query", %{client: client} do
      mock_call(:get, "/products/mine")

      response = Products.list_mine(client)
      assert client_response(response, 200)
    end

    test "calls api with query", %{client: client} do
      mock_call(:get, "/products/mine", query: [search: "search"])

      response = Products.list_mine(client, search: "search")
      assert client_response(response, 200)
    end
  end

  describe "update/3 calls api" do
    @update_attrs %{
      source: %{
        hidden: true
      }
    }

    test "update/3 calls api", %{client: client} do
      mock_call(:put, "/products/id", body: @update_attrs)

      response = Products.update(client, "id", @update_attrs)
      assert client_response(response, 200)
    end
  end
end
