defmodule AdventOfCode2020.Day11SeatingSystemTest do
    use ExUnit.Case

    import AdventOfCode2020.Day11SeatingSystem

    @example_input """
    L.LL.LL.LL
    LLLLLLL.LL
    L.L.L..L..
    LLLL.LL.LL
    L.LL.LL.LL
    L.LLLLL.LL
    ..L.L.....
    LLLLLLLLLL
    L.LLLLLL.L
    L.LLLLL.LL
    """

    describe "part_1/1" do
        test "example input" do
            assert 37 = @example_input |> String.trim() |> part_1()
        end

        @tag :slow
        test "with puzzle input" do
            assert 2251 = puzzle_input() |> String.trim() |> part_1()
        end
    end

    describe "part_2/1" do
        test "example input" do
           assert 26 = @example_input |> String.trim() |> part_2()
        end

        # @tag timeout: :infinity
        # test "with puzzle input" do
        #    assert 0 = puzzle_input() |> String.trim() |> part_2()
        # end
    end
end
