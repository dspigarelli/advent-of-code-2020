File.read!("input")
|> String.split("\n\n", trim: true)
|> Enum.map(fn s ->
    String.replace(s, ~r/\n/, "")
    |> String.graphemes
    |> Enum.uniq
    |> Enum.count
end)
|> Enum.reduce(0, fn item, acc -> acc + item end)
|> IO.inspect()