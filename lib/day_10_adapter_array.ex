defmodule AdventOfCode2020.Day10AdapterArray do
    use AdventOfCode2020

    def part_1(input) do
        input
        |> parse()
        |> (fn ls -> find_count_of_delta(ls, 3) * find_count_of_delta(ls, 1) end).()
    end

    def part_2(input) do
        # input
        1
    end

    defp parse(input) do
        input
        |> String.split("\n")
        |> Enum.map(&String.to_integer/1)
        |> Enum.sort
    end

    defp find_count_of_delta(list, target) do
        2
    end
end	