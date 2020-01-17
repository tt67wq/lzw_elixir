defmodule LzwElixir do
  @moduledoc """
  Lzw compress

  [document](https://en.wikipedia.org/wiki/Lempel%E2%80%93Ziv%E2%80%93Welch)
  """

  @min_code 256
  @doc """
  压缩

  * `data` - origin binary

  ## Examples

  iex> LzwElixir.compress("that is what i said")
  [116, 104, 97, 116, 32, 105, 115, 32, 119, 257, 259, 105, 32, 115, 97, 105, 100]
  """
  @spec compress(binary) :: [integer]
  def compress(data), do: do_compress(data, %{}, <<>>, @min_code, [])

  @doc """
  Description of this function

  * list - compressed result nums


  ## Examples

  iex> LzwElixir.decompress([116, 104, 97, 116, 32, 105, 115, 32, 119, 257, 259, 105, 32, 115, 97, 105, 100])
  "that is what i said"
  """
  @spec decompress([integer]) :: binary
  def decompress([]), do: ""
  def decompress([h | t]), do: do_decompress(t, @min_code, <<h>>, %{}, <<h>>)

  defp do_compress("", dict, buffer, _code, acc),
    do: Enum.reverse([get_dict_idx(buffer, dict) | acc])

  defp do_compress(<<c, rest::binary>>, dict, buffer, code, acc) do
    item = buffer <> <<c>>

    case get_dict_idx(item, dict) do
      nil ->
        # not in dict
        do_compress(<<rest::binary>>, Map.put(dict, item, code), <<c>>, code + 1, [
          get_dict_idx(buffer, dict) | acc
        ])

      _idx ->
        # ascii or in dict
        do_compress(<<rest::binary>>, dict, item, code, acc)
    end
  end

  defp get_dict_idx(<<c::8>>, _dict) when c < @min_code, do: c
  defp get_dict_idx(buffer, dict), do: Map.get(dict, buffer)

  defp do_decompress([], _code, _buffer, _dict, acc), do: acc

  defp do_decompress([c | t], code, buffer, dict, acc) do
    case get_dict_chars(c, dict) do
      nil ->
        # not in dict
        <<first::8, _rest::binary>> = buffer
        chars = buffer <> <<first>>
        do_decompress(t, code + 1, chars, Map.put(dict, code, chars), acc <> chars)

      chars ->
        # in dict
        do_decompress(t, code + 1, chars, Map.put(dict, code, buffer <> chars), acc <> chars)
    end
  end

  defp get_dict_chars(c, _dict) when c < @min_code, do: <<c>>
  defp get_dict_chars(idx, dict), do: Map.get(dict, idx)
end
