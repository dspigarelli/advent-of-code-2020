defmodule AdventOfCode2020.Day01ReportRepair do
    use AdventOfCode2020

    def part_1(input) do
        input
        |> parse
        |> Enum.with_index
        |> (fn list ->
            for x <- list, y <- list, do: [x,y]
        end).()
        |> Enum.filter(fn
            [{_, x}, {_, x}] -> false
            [{x, _}, {y, _}] -> x + y == 2020
        end)
        |> List.first
        |> (fn [{x, _}, {y, _}] -> x*y end).()
    end

    def part_2(input) do
       input
       |> parse
       |> (fn list ->
            ln = length(list) - 1
            for x <- 0..(ln-2), y <-(x+1)..(ln-1), z <- (y+1)..ln do
                [Enum.at(list,x), Enum.at(list,y), Enum.at(list,z)]
            end
        end).()
        |> Enum.filter(fn ls -> Enum.sum(ls) == 2020 end)
        |> List.first
        |> Enum.reduce(1, fn x, accum -> x * accum end)

    #    |> (fn list ->
    #         for x <- list, y <- list, z <- list, do: [x,y,z]
    #     end).()
    #     |> Enum.reduce(nil, fn [{x, a}, {y, b}, {z, c}], accum ->
    #         cond do
    #             a == b || b == c || a == c -> accum
    #             x + y + z == 2020 -> [x, y, z]
    #             true -> accum
    #         end
    #     end)
    #     |> Enum.reduce(1, fn x, accum -> x * accum end)

    #     |> Enum.filter(fn
    #         [{_, x}, {_, x}, _] -> false
    #         [{_, x}, _, {_, x}] -> false
    #         [_, {_, x}, {_, x}] -> false
    #         [{x, _}, {y, _}, {z, _}] -> x + y + z == 2020
    #     end)
    #     |> List.first
    #     |> (fn [{x, _}, {y, _}, {z, _}] -> x*y*z end).()
    end

    defp parse(input) do
        input
        |> String.split("\n", trim: true)
        |> Enum.map(&String.to_integer/1)
        # |> Enum.with_index
    end
end
