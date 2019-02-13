defmodule MoelabServerWeb.Schema.Utils.Helper do
  # see: https://github.com/absinthe-graphql/absinthe/issues/363
  defmacro pagination_args() do
    quote do
      field(:page, :integer, default_value: 1)
      field(:size, :integer, default_value: 10)
    end
  end

  defmacro pagination_fields do
    quote do
      field(:total_count, :integer)
      field(:page_size, :integer)
      field(:total_pages, :integer)
      field(:page_number, :integer)
    end
  end
end
