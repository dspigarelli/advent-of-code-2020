defmodule AdventOfCode2020.Day02PasswordPhilosophyTest do
    use ExUnit.Case

    import AdventOfCode2020.Day02PasswordPhilosophy

    @example_input """
    1-3 a: abcde
    1-3 b: cdefg
    2-9 c: ccccccccc
    """

    describe "part_1/1" do
        test "example input" do
            assert 2 = @example_input |> String.trim() |> part_1()
        end

        test "with puzzle input" do
            assert 422 = puzzle_input() |> String.trim() |> part_1()
        end
    end

    describe "part_2/1" do
        test "example input" do
           assert 1 = @example_input |> String.trim() |> part_2()
        end

        test "with puzzle input" do
           assert 451 = puzzle_input() |> String.trim() |> part_2()
        end
    end
end
