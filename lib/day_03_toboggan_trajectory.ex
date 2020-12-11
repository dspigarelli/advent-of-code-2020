defmodule AdventOfCode2020.Day03TobogganTrajectory do
    use AdventOfCode2020

    def part_1(input) do
        input
        |> parse
        |> (fn list ->
            findTreesInSlope(list, 3, 1)
        end).()
    end

    def part_2(input) do
        input
        |> parse
        |> (fn list ->
            findTreesInSlope(list, 1,1) *
            findTreesInSlope(list, 3,1) *
            findTreesInSlope(list, 5,1) *
            findTreesInSlope(list, 7,1) *
            findTreesInSlope(list, 1,2)
        end).()
    end

    defp parse(input) do
        input
        |> String.split("\n", trim: true)
        |> Enum.map(&String.graphemes/1)
    end

    defp findTreesInSlope(rows, slopeX, slopeY) do
        Enum.at(Enum.reduce(rows, [0, 0, 0], fn row, [treeCnt, x, y] ->
            checkRow = rem(y, slopeY) == 0
            # IO.inspect([row, treeCnt, x, y, checkRow, if checkRow and y != 0 do Enum.at(row, x) else "" end])
            [
                treeCnt+(if checkRow and y != 0 and Enum.at(row,x) == "#" do 1 else 0 end),
                if checkRow do rem(x+slopeX, length(row)) else x end,
                y+1
            ]
        end), 0)
    end
end
