defmodule AdventOfCode2020.Day15RambunctiousRecitation do
    use AdventOfCode2020

    def part_1(input) do
        input
        |> parse
        |> (fn numbers ->
            map = numbers
            |> Enum.with_index()
            |> Enum.into(%{}, fn {k,v} -> {k, [nil, v]} end)

            [_, last2020] = Enum.reduce(
                Enum.count(numbers)..2019,
                [map, List.last(numbers)],
                fn idx, [map, last] -> evolve(map, idx-1, last) end
            )
            last2020
        end).()
    end

    def part_2(input) do
        input
        |> parse
        |> (fn numbers ->
            map = numbers
            |> Enum.with_index()
            |> Enum.into(%{}, fn {k,v} -> {k, [nil, v]} end)

            [_, last2020] = Enum.reduce(
                Enum.count(numbers)..(30_000_000 - 1),
                [map, List.last(numbers)],
                fn idx, [map, last] -> evolve(map, idx-1, last) end
            )
            last2020
        end).()
    end

    defp evolve(indexMap, index, currentNumber) do
        [n1, n2] = Map.get(indexMap, currentNumber)

        newNumber = cond do
            n1 == nil -> 0
            true -> n2 - n1
        end

        newPair = Map.get(indexMap, newNumber)
        cond do
            newPair == nil -> [Map.put(indexMap, newNumber, [nil, index+1]), newNumber]
            true -> [_, n3] = newPair
                [Map.put(indexMap, newNumber, [n3, index+1]), newNumber]
        end
    end

    defp parse(input) do
        input
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)
    end
end
