defmodule ReverbApp.Types do
  alias ReverbApp.Types, as: T

  defmodule Href do
    defstruct [:href]
    @type t :: %Href{href: String.t()}
  end

  defmodule CategoryLinks do
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

   defimpl Poison.Encoder, for: Href do
     def encode(json) do
       Poison.Encoder.Map.encode(json)
     end
   end

   defimpl Poison.Encoder, for: CategoryLinks do
     def encode(json) do
       Poison.Encoder.Map.encode(json)
     end
   end


  defmodule Category do
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

   defimpl Poison.Encoder, for: Category do
     def encode(json) do
       Poison.Encoder.Map.encode(json)
     end
   end

 end
