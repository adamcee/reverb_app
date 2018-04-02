defmodule ReverbServer.Types do
  @moduledoc """
  Types for working with JSON returned by the Reverb API
  """

  alias ReverbServer.Types, as: T

  defmodule Href do
    @enforce_keys [:href]
    defstruct [:href]
    @type t :: %Href{href: String.t()}
  end

  defmodule CategoryLinks do
    @enforce_keys [:collection_header_image, :follow, :image,
      :listings, :self, :follow, :web]
    defstruct [:collection_header_image, :follow, :image,
      :listings, :self, :follow, :web]

    @type t:: %CategoryLinks {
      collection_header_image: %Href{},
      follow: %Href{},
      image: %Href{},
      listings: %Href{},
      self: %Href{},
      follow: %Href{},
      web: %Href{}
    }

  end

  defmodule Category do
    @enforce_keys [:_links, :collection_title, :collection_title,
      :full_name, :listable, :name, :root_slug, :root_uuid,
      :slug, :uuid]
    defstruct [:_links, :collection_title, :collection_title,
      :full_name, :listable, :name, :root_slug, :root_uuid,
      :slug, :uuid]

    @type t :: %Category{
      _links: %CategoryLinks{},
      collection_title: String.t(),
      full_name: String.t(),
      listable: boolean(),
      name: String.t(),
      root_slug: String.t(),
      root_uuid: String.t(),
      slug: String.t(),
      uuid: String.t(),
    }
  end

 end
