defmodule ReverbApp.Utils do
  # from: https://stackoverflow.com/posts/30700541/revisions
  defmodule ValidateUri do
    def validate_uri(str) do
      uri = URI.parse(str)
      case uri do
        %URI{scheme: nil} -> {:error, uri}
        %URI{host: nil} -> {:error, uri}
        %URI{path: nil} -> {:error, uri}
        uri -> {:ok, uri}
      end
    end
  end

end
