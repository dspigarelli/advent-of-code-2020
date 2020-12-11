defmodule AdventOfCode2020.Day02PasswordPhilosophy do
    use AdventOfCode2020

    def part_1(input) do
        input
        |> parse
        |> Enum.filter(fn [policy, pwd] ->
            [cnt, char] = String.split(policy, " ", trim: true)
            [low, hi] = String.split(cnt, "-", trim: true)
                |> Enum.map(&String.to_integer/1)

            occurrences = pwd |> String.graphemes |> Enum.count(fn(c) -> c == char end)
            occurrences <= hi && occurrences >= low
        end)
        |> Enum.count
    end

    def part_2(input) do
        input
        |> parse
        |> Enum.filter(fn [policy, pwd] ->
            [cnt, char] = String.split(policy, " ", trim: true)
            [pos1, pos2] = String.split(cnt, "-", trim: true)
                |> Enum.map(&String.to_integer/1)

            first = char == String.at(pwd, pos1-1)
            second = char == String.at(pwd, pos2-1)

            (first || second) && !(first && second)
        end)
        |> Enum.count
    end

    defp parse(input) do
        input
        |> String.split("\n", trim: true)
        |> Enum.map(fn policy -> String.split(policy, ": ", trim: true) end)
    end
end
