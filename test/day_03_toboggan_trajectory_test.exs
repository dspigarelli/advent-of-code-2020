defmodule AdventOfCode2020.Day03TobogganTrajectoryTest do
    use ExUnit.Case

    import AdventOfCode2020.Day03TobogganTrajectory

    @example_input """
    ..##.......
    #...#...#..
    .#....#..#.
    ..#.#...#.#
    .#...##..#.
    ..#.##.....
    .#.#.#....#
    .#........#
    #.##...#...
    #...##....#
    .#..#...#.#
    """

    describe "part_1/1" do
        test "example input" do
            assert 7 = @example_input |> String.trim() |> part_1()
        end

        test "with puzzle input" do
            assert 276 = puzzle_input() |> String.trim() |> part_1()
        end
    end

    describe "part_2/1" do
        test "example input" do
           assert 336 = @example_input |> String.trim() |> part_2()
        end

        test "with puzzle input" do
           assert 7_812_180_000 = puzzle_input() |> String.trim() |> part_2()
        end
    end
end
