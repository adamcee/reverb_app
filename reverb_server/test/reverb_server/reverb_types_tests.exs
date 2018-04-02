defmodule ReverbServer.ReverbTypesTest do
  ExUnit.start()

  defmodule ReverbServerUtilsTest do
    use ExUnit.Case, async: true
    alias ReverbServer.Utils, as: U

    test "ReverbServer.Utils.get_json_file returns error for a nonexistent file" do
      case U.get_json_file("mock_data/this_definitely_does_not_exist.json") do
        {:error, _ } -> assert true
         _ -> assert false
      end
    end

    test "ReverbServer.Utils.get_json_file correctly retrieves and parses a .json file." do
      case U.get_json_file("mock_data/mock_categories.json") do
        {:error, _ } -> assert false
        {:ok, json} ->
          case Map.has_key?(json, "categories") do
            true -> assert true
            false -> assert false
          end
      end
    end

  end

end