defmodule ReverbServer.TypesTest do
  @moduledoc false

  require Logger
  alias ReverbServer.Types, as: T
  ExUnit.start()

  defmodule HelpersTest do
    use ExUnit.Case, async: true
    test "assert flatten_href returns an atom map containing the link value" do
      mock = {"google", %{"href" => "http://google.com"}}
      case T.flatten_href(mock) do
        {:google, "http://google.com"} -> assert true
        _ -> assert false
      end
    end
  end

  defmodule LinkTest do
    use ExUnit.Case, async: true
    test "assert Link.from_str_map creates a Link structure from json" do
      # get map of json from string, like we would from an http response
      {:ok, json} = Poison.encode(%{href: "http://google.com"})
      json = Poison.decode!(json)

      case T.Link.from_str_map(json) do
        _correct = %T.Link{} -> assert true
        _ -> assert false
      end
    end

    test "assert Link.from_str_map converts method val to atom - \"get\" to :get" do
      # get map of json from string, like we would from an http response
      {:ok, json} = Poison.encode(%{href: "http://google.com", method: "get"})
      json = Poison.decode!(json)

      case T.Link.from_str_map(json) do
       %T.Link{href: "http://google.com", method: :get} -> assert true
      end
    end
  end

end