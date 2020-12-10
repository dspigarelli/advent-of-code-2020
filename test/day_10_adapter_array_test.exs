defmodule AdventOfCode2020.Day10AdapterArrayTest do
    use ExUnit.Case

    import AdventOfCode2020.Day10AdapterArray

    @example_input """
    16
    10
    15
    5
    1
    11
    7
    19
    6
    12
    4
    """

    describe "part_1/1" do
        test "multiple count of 1 jolt and 3 jolt" do
            assert 35 = @example_input |> String.trim() |> part_1()
        end
    end
end