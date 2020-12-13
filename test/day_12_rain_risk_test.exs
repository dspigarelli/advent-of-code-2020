defmodule AdventOfCode2020.Day12RainRiskTest do
    use ExUnit.Case

    import AdventOfCode2020.Day12RainRisk

    @example_input """
    F10
    N3
    F7
    R90
    F11
    """

    describe "part_1/1" do
        test "example input" do
            assert 25 = @example_input |> String.trim() |> part_1()
        end

        test "with puzzle input" do
            assert 1_106 = puzzle_input() |> String.trim() |> part_1()
        end
    end

    describe "part_2/1" do
        # test "example input" do
        #    assert 0 = @example_input |> String.trim() |> part_2()
        # end

        # test "with puzzle input" do
        #    assert 0 = puzzle_input() |> String.trim() |> part_2()
        # end
    end
end
