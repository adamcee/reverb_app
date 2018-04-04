defmodule ReverbServer.Utils do
  @moduledoc """
  Utility/Helper functions
  """

  require Logger
  alias ReverbServer.Utils, as: U

  @doc """
  Get JSON file and return a map of the JSON
  Returns `{:ok, %{}}` | `{:error, reason}`
  """
  def get_json_file(path_from_proj_root) do
    case get_file(path_from_proj_root) do
      {:ok, body} -> {:ok, Poison.decode!(body)}
      {:error, reason} -> {:error, reason}
       _ -> {:error, :failure}
    end
  end

  @doc """
  Returns `{:ok, String.t}` | `{:error, reason}`
  """
  def get_file(path_from_proj_root) do
    path = Path.join(File.cwd!, path_from_proj_root)
    case File.read(path) do
      {:ok, body} -> {:ok, body}
      {:error, reason} -> {:error, reason}
      _ -> {:error, :failure}
    end
  end

  @doc """
  str_map %{} map with all string keys
  Returns the map, values unchanged, with all keys as atoms
  """
  def str_keys_to_atoms(str_map = %{}) do
    str_map
    |> Map.to_list
    |> Enum.map(fn {k, v} ->  {String.to_atom(k), v} end)
    |> Enum.into(%{})
  end


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

end
