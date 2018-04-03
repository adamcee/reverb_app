defmodule ReverbServer.UtilsTest do
  @moduledoc false
  ExUnit.start()

  defmodule GetFileTest do
    use ExUnit.Case, async: true
    alias ReverbServer.Utils, as: U

    test "ReverbServer.Utils.get_file returns error for a nonexistent file" do
      case U.get_json_file("mock_data/this_definitely_does_not_exist.json") do
        {:error, _ } -> assert true
        _ -> assert false
      end
    end

    test "ReverbServer.Utils.get_file correctly retrieves a file." do
      case U.get_file("mock_data/mock_categories.json") do
        {:ok, body} when is_binary(body) -> assert true
         _ -> assert false
      end
    end

  end

  defmodule GetJsonFileTest do
    use ExUnit.Case, async: true
    alias ReverbServer.Utils, as: U

    test "ReverbServer.Utils.get_json_file correctly retrieves and parses a .json file." do
      case U.get_json_file("mock_data/mock_categories.json") do
        {:ok, json} ->
          case Map.has_key?(json, "categories") do
            true -> assert true
            false -> assert false
          end
          _ -> assert false
      end
    end

  end

end