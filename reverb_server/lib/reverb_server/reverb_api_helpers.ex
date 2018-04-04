defmodule ReverbServer.ReverbAPIHelpers do
  @moduledoc """
  Tools which use the ReverbAPI module and do something with the data,
  or, manipulate said data once it has been retrieved.
  """

  alias ReverbServer.ReverbAPI, as: API
  alias ReverbServer.CategoryTypes, as: CT
  require Logger

  @doc """
  HTTP GETS all Reverb categories. Then filters category list for those
  whose full name contains the token string param.
  token - String token. Default val of "" will return all categories.
  returns - List of categories whose full name contains the desired string token.
  """
  def get_categories_with_string(token \\ "") do
    case API.get_categories_flat() do
      {:error, msg} ->
        {:error, msg}
      {:ok, %CT.CategoriesFlat{} = cat_flat} ->
        {:ok, Enum.filter(cat_flat.categories, fn(c) ->
          String.contains?(String.downcase(c.full_name), String.downcase(token)) end)}
    end
  end

end
