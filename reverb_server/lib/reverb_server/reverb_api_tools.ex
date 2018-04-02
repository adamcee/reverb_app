defmodule ReverbApp.ReverbAPITools do
  @moduledoc """
  Tools which use the ReverbAPI module and do something with the data,
  or, manipulate said data once it has been retrieved.
  """

  alias ReverbApp.ReverbAPI, as: API
  require Logger

  @doc """
  HTTP GETS all Reverb categories. Then filters category list for those
  whose full name contains the token string param.
  token - String token. Default val of "" will return all categories.
  returns - List of categories whose full name contains the desired string token.
  """
  def get_categories_with_string(token \\ "") do
    case API.get_categories_flat() do
      {:error, _} -> :error
      {:ok, %{"categories" => categories}} ->
      Enum.filter(categories, fn(c) -> is_in_category_name(token, c) end)
    end
  end

  @doc """
  token - String token
  cat - Category map
  returns - Boolean
  """
  defp is_in_category_name(token, cat) do
    String.contains?(String.downcase(cat["full_name"]), String.downcase(token))
  end

end
