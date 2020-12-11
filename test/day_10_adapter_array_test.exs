defmodule AdventOfCode2020.Day10AdapterArrayTest do
    use ExUnit.Case

    import AdventOfCode2020.Day10AdapterArray

    @example_input_1 """
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

    @example_input_2 """
    28
    33
    18
    42
    31
    14
    46
    20
    48
    47
    24
    23
    49
    45
    19
    38
    39
    11
    1
    32
    25
    35
    8
    17
    7
    9
    4
    2
    34
    10
    3
    """

    describe "part_1/1" do
        test "example 1" do
            assert 35 = @example_input_1 |> String.trim() |> part_1()
        end

        test "example 2" do
            assert 220 = @example_input_2 |> String.trim() |> part_1()
        end

        test "with puzzle input" do
            assert 1_656 = puzzle_input() |> String.trim() |> part_1()
        end
    end

    describe "part_2/1" do
        # test "" do
        #    assert "" = @example_input |> String.trim() |> part_2()
        # end

        # test "with puzzle input" do
        #    assert "" = puzzle_input() |> String.trim() |> part_2()
        # end
    end
end
