defmodule ReverbApp.ReverbAPITools do
  alias ReverbApp.ReverbAPI, as: API
  require Logger

  @doc """
  Return list of all categories whose full name contains the str_token param.
  Default str_token val is empty string, all categories will be returned.
  """
  def get_categories_containing(str_token \\ "") do
    case API.get_categories_flat() do
      {:error, _} -> :error
      {:ok, %{"categories" => categories}} ->
        Logger.info("Do stuff here!")
        Enum.filter(categories, fn(cat) -> is_in_category_name(str_token, cat) end)
    end
  end

  defp is_in_category_name(str_token, category) do
    Logger.info("Comparing #{str_token} to cat #{inspect category["full_name"]}")
    str_token = String.downcase(str_token)
    full_name = String.downcase(category["full_name"])
    String.contains?(full_name, str_token)
  end

end
