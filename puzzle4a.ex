# s
# IO.read(:stdio, :all)
File.read!("input")
|> String.split("\n\n", trim: true)
|> Enum.filter((fn str ->
    Regex.split(~r{\s+}, str)
    # |> Enum.map(&IO.inspect/1)
    |> Enum.map(fn str -> Enum.at(String.split(str, ":"), 0) end)
    |> (fn keys ->
        MapSet.subset?(
            MapSet.new(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]),
            MapSet.new(keys)
        )
    end).()
end))
|> Enum.map(&IO.inspect/1)
|> Enum.count()
|> IO.inspect()