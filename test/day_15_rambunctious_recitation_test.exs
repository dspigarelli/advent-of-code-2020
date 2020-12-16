defmodule AdventOfCode2020.Day15RambunctiousRecitationTest do
    use ExUnit.Case

    import AdventOfCode2020.Day15RambunctiousRecitation

    describe "part_1/1" do
        test "example input #0" do
            assert 436 = "0,3,6" |> String.trim() |> part_1()
        end

        test "example input #1" do
            assert 1 = "1,3,2" |> String.trim() |> part_1()
        end

        test "example input #2" do
            assert 10 = "2,1,3" |> String.trim() |> part_1()
        end

        test "example input #3" do
            assert 27 = "1,2,3" |> String.trim() |> part_1()
        end

        test "example input #4" do
            assert 78 = "2,3,1" |> String.trim() |> part_1()
        end

        test "example input #5" do
            assert 438 = "3,2,1" |> String.trim() |> part_1()
        end

        test "example input #6" do
            assert 1_836 = "3,1,2" |> String.trim() |> part_1()
        end

        test "with puzzle input" do
            assert 1_280 = puzzle_input() |> String.trim() |> part_1()
        end
    end

    describe "part_2/1" do
        @tag :slow
        test "example input #0" do
            assert 175_594 = "0,3,6" |> String.trim() |> part_2()
        end

        @tag :slow
        test "with puzzle input" do
            assert 651_639 = puzzle_input() |> String.trim() |> part_2()
        end
    end
end
