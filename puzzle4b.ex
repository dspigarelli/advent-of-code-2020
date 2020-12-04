defmodule Passport do
    def validateRange(value, low, high) do
        case Integer.parse(value, 10) do
            { :error, _ } -> false
            { x, _} when x >= low and x <= high -> true
            _ -> false
        end
    end

    def validateFields(fields) do
        Enum.filter(fields, fn field ->
            case Enum.at(field, 0) do
                "byr" -> validateRange(Enum.at(field, 1), 1920, 2002)
                "iyr" -> validateRange(Enum.at(field, 1), 2010, 2020)
                "eyr" -> validateRange(Enum.at(field, 1), 2020, 2030)
                "hgt" ->
                    matches = Regex.run(~r/^(\d+)(in|cm)$/, Enum.at(field, 1))
                    if matches == nil do
                        false
                    else
                        (fn [_, hgt, unit] ->
                            case unit do
                                "cm" -> validateRange(hgt, 150, 193)
                                "in" -> validateRange(hgt, 59, 76)
                                _ -> false
                            end
                        end).(matches)
                    end
                "hcl" -> String.match?(Enum.at(field, 1), ~r/^#[a-f0-9]{6}$/i)
                "pid" -> String.match?(Enum.at(field, 1), ~r/^\d{9}$/i)
                "ecl" -> String.match?(Enum.at(field, 1), ~r/^amb|blu|brn|gry|grn|hzl|oth$/)
                "cid" -> true
                _ -> true
            end
        end)
        |> Enum.map(fn field -> Enum.at(field, 0) end)
        |> (fn keys -> MapSet.subset?(
            MapSet.new(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]),
            MapSet.new(keys)
        ) end).()
    end
end

# s
# IO.read(:stdio, :all)
File.read!("input")
|> String.split("\n\n", trim: true)
|> Enum.filter((fn str ->
    Regex.split(~r{\s+}, str)
    # |> Enum.map(&IO.inspect/1)
    |> Enum.map(fn str -> String.split(str, ":") end)
    |> (fn obj -> Passport.validateFields(obj) end).()
end))
|> Enum.map(&IO.inspect/1)
|> Enum.count()
|> IO.inspect()