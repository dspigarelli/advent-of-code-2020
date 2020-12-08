File.read!("input")
|> String.split("\n\n", trim: true)
|> Enum.map(fn s ->
    String.split(s, "\n", trim: true)
    |> Enum.map(fn s -> MapSet.new(String.graphemes(s)) end)
    |> Enum.reduce(fn item, acc -> MapSet.intersection(item, acc) end)
    |> Enum.count
end)
|> Enum.reduce(0, fn item, acc -> acc + item end)
|> IO.inspect()