defmodule ExFigures.Products do
  @moduledoc """
  The [/products](https://docs.appfigures.com/products) resource provides
  access to product meta data in a variety of ways.
  """

  @typedoc """
  Most places you can be given products you can also ask for additional data
  from the products by appending the `meta: true` to your request.
  """
  @type meta_opt :: {:meta, boolean}

  @typedoc """
  Represents products searching query arguments
  """
  @type search_opt ::
          {:filter, binary}
          | {:page, integer}
          | {:count, integer}
          | meta_opt

  @typedoc """
  Represents user products query arguments
  """
  @type mine_opt :: {:store, binary} | meta_opt

  @typedoc """
  Represents update product query argument
  """
  @type update_attrs :: %{source: %{optional(:active) => boolean, optional(:hidden) => boolean}}

  @doc """
  Getting a product by its Appfigures ID
  """
  @spec get_by_appfigures_id(ExFigures.t(), binary) :: ExFigures.result()
  def get_by_appfigures_id(client, appfigures_id) do
    Tesla.get(client, "/products/" <> appfigures_id)
  end

  @doc """
  Getting a product by its id in the store
  """
  @spec get_by_store_id(ExFigures.t(), binary, binary) :: ExFigures.result()
  def get_by_store_id(client, store, store_id) do
    Tesla.get(client, "/products/" <> store <> "/" <> store_id)
  end

  @doc """
  Searching for products.
  The Public Data API add-on is required for this route.
  Scope: This resource requires the public:read scope.

  Query options:
    * `:term` - The name of an app or a developer.
      Prefix with @name= or @developer= if you’d like to search that field only.
    * `:filter` - Filter to apply to the results: one of `ios`, `mac`, `google`, `amazon`.
      Defaults to showing all results
    * `:page` - Page of results to show. Defaults to the first page
    * `:count` - Number of results to show in a page. Defaults to 25
  """
  @spec search(ExFigures.t(), binary, [search_opt]) :: ExFigures.result()
  def search(client, term, query \\ []) do
    Tesla.get(client, "/products/search/" <> term, query: query)
  end

  @doc """
  Listing all of your products

  Query options:
    * `:store` - Filter to only show products from a given store.
      `apple`, `google_play`, `amazon_appstore` are some valid examples.
  """
  @spec list_mine(ExFigures.t(), [mine_opt]) :: ExFigures.result()
  def list_mine(client, query \\ []) do
    Tesla.get(client, "/products/mine", query: query)
  end

  @doc """
  Updating products

  Attribures:
    * `:source`
      - `:active` - `true/false`
      - `:hidden` - `true/false`
  """
  @spec update(ExFigures.t(), binary, update_attrs) :: ExFigures.result()
  def update(client, appfigures_id, attrs) do
    Tesla.put(client, "/products/" <> appfigures_id, attrs)
  end
end
