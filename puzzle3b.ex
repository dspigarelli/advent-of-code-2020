defmodule Tobogan do
    def findTreesInSlope(rows, slopeX, slopeY) do
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

# s
# IO.read(:stdio, :all)
File.read!("input")
|> String.split("\n", trim: true)
|> Enum.map(&String.graphemes/1)
|> (fn list -> (
    Tobogan.findTreesInSlope(list, 1,1) *
    Tobogan.findTreesInSlope(list, 3,1) *
    Tobogan.findTreesInSlope(list, 5,1) *
    Tobogan.findTreesInSlope(list, 7,1) *
    Tobogan.findTreesInSlope(list, 1,2)
    )
end).()
|> IO.inspect()
