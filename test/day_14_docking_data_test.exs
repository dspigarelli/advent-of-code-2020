defmodule AdventOfCode2020.Day14DockingDataTest do
    use ExUnit.Case

    import AdventOfCode2020.Day14DockingData

    @example_input """
    mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
    mem[8] = 11
    mem[7] = 101
    mem[8] = 0
    """

    describe "part_1/1" do
        test "example input" do
            assert 165 = @example_input |> String.trim() |> part_1()
        end

        test "with puzzle input" do
            assert 10_035_335_144_067 = puzzle_input() |> String.trim() |> part_1()
        end
    end

    describe "part_2/1" do
        # test "example input" do
        #    assert 208 = @example_input |> String.trim() |> part_2()
        # end

        # test "with puzzle input" do
        #    assert 0 = puzzle_input() |> String.trim() |> part_2()
        # end
    end
end
