defmodule AdventOfCode2020.Day14DockingData do
    use AdventOfCode2020
    use Bitwise

    def part_1(input) do
        input
        |> parse
        |> Enum.reduce({ 0, 0, %{}}, fn [action, value], { orMask, andMask, accum} -> calc(action, value, orMask, andMask, accum) end)
        |> (fn {_, _, map} -> Map.values(map) end).()
        |> Enum.sum()
    end

    # def part_2(input) do
    #     input
    #     |> parse
    # end

    defp calc("mask", value, _orMask, _andMask, map) do
        {
            value |> String.replace("X", "0", global: true) |> String.to_integer(2),
            value |> String.replace("X", "1", global: true) |> String.to_integer(2),
            map
        }
    end

    defp calc(other, value, orMask, andMask, map) do
        [_, address] = Regex.run(~r/^mem\[(\d+)\]$/, other)
        {
            orMask,
            andMask,
            Map.put(map, String.to_integer(address), (String.to_integer(value) &&& andMask) ||| orMask)
        }
    end

    defp parse(input) do
        for instruction <- input |> String.split("\n") do
            [ action, value] = instruction |> String.split(" = ")
            # { code, count } = String.split_at(instruction, 1)
            # { direction(code), String.to_integer(count) }
        end
    end
end
