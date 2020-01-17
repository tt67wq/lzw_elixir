# LzwElixir

**Lzw compression algorithm implement in Elixir**

## Usage
```
iex> LzwElixir.compress("that is what i said")
[116, 104, 97, 116, 32, 105, 115, 32, 119, 257, 259, 105, 32, 115, 97, 105, 100]

iex> LzwElixir.decompress([116, 104, 97, 116, 32, 105, 115, 32, 119, 257, 259, 105, 32, 115, 97, 105, 100])
"that is what i said"
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `lzw_elixir` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:lzw_elixir, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/lzw_elixir](https://hexdocs.pm/lzw_elixir).

