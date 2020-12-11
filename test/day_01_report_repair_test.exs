defmodule AdventOfCode2020.Day01ReportRepairTest do
    use ExUnit.Case

    import AdventOfCode2020.Day01ReportRepair

    @example_input """
    1721
    979
    366
    299
    675
    1456
    """

    describe "part_1/1" do
        test "example input" do
            assert 514_579 = @example_input |> String.trim() |> part_1()
        end

        @tag :slow
        test "with puzzle input" do
            assert 646_779 = puzzle_input() |> String.trim() |> part_1()
        end
    end

    describe "part_2/1" do
        test "example input" do
            assert 241_861_950 = @example_input |> String.trim() |> part_2()
        end

        @tag :slow
        test "with puzzle input" do
            assert 246_191_688 = puzzle_input() |> String.trim() |> part_2()
        end
    end
end
