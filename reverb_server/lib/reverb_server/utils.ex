defmodule ReverbServer.Utils do
  @moduledoc """
  Utility/Helper functions
  """

#  # from: https://stackoverflow.com/posts/30700541/revisions
#  defmodule ValidateUri do
#    def validate_uri(str) do
#      uri = URI.parse(str)
#      case uri do
#        %URI{scheme: nil} -> {:error, uri}
#        %URI{host: nil} -> {:error, uri}
#        %URI{path: nil} -> {:error, uri}
#        uri -> {:ok, uri}
#      end
#    end
#  end
#
#end
#
#
 @doc """
 Convert a map with string keys to a struct
 from: https://groups.google.com/forum/#!msg/elixir-lang-talk/6geXOLUeIpI/L9einu4EEAAJ

  kind: The struct to create
  attr: A map with string keys

  Returns a struct of type kind
  NOTE: Be careful using this with structs with nested structures!!
 """
 def to_struct(kind, attrs) do
    struct = struct(kind)
    Enum.reduce Map.to_list(struct), struct, fn {k, _}, acc ->
      case Map.fetch(attrs, Atom.to_string(k)) do
        {:ok, v} -> %{acc | k => v}
        :error -> acc
      end
    end
   end

end
