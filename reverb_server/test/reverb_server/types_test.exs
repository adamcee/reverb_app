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

end