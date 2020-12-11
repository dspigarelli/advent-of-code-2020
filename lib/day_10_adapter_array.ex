defmodule AdventOfCode2020.Day10AdapterArray do
    use AdventOfCode2020

    def part_1(input) do
        input
        |> parse
        |> (fn ls -> [0] ++ ls ++ [List.last(ls)+3] end).()
        |> (fn ls ->
            Stream.unfold(
                { 0, Enum.slice(ls, 0, 2) },
                fn
                    { _, [ _ ]} -> nil
                    { index, pair } ->
                        { { index, pair }, { index + 1, Enum.slice(ls, index + 1, 2) } }
                end)
            |> Enum.map(fn {_, [first, second] } -> second - first end)
            end).()
        |> Enum.reduce({ 0, 0 }, fn
            1, { one, three } -> { one + 1, three }
            3, { one, three } -> { one, three + 1 }
            _, acc -> acc
        end)
        |> (fn { one, three} -> one * three end).()
    end

    # def part_2(input) do
    #    # input
    #end

    defp parse(input) do
        input
        |> String.split("\n")
        |> Enum.map(&String.to_integer/1)
        |> Enum.sort
    end
end
