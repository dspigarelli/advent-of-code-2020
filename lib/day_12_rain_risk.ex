defmodule AdventOfCode2020.Day12RainRisk do
    use AdventOfCode2020

    def part_1(input) do
        input
        |> parse
        |> Enum.reduce({0, 0, 0}, &move/2)
        |> (fn { heading, x, y } -> abs(x) + abs(y) end).()
    end

    # def part_2(input) do
    #     input
    #     |> parse
    # end

    defp parse(input) do
        for instruction <- input |> String.split() do
            { code, count } = String.split_at(instruction, 1)
            { direction(code), String.to_integer(count) }
        end
    end

    defp move({ :north, amount }, { heading, x, y }), do: { heading, x, y+amount }
    defp move({ :south, amount }, { heading, x, y }), do: { heading, x, y-amount }
    defp move({ :east, amount }, { heading, x, y }), do: { heading, x+amount, y }
    defp move({ :west, amount }, { heading, x, y }), do: { heading, x-amount, y }

    defp move({ :left, amount }, { heading, x, y }), do: { heading + amount, x, y}
    defp move({ :right, amount }, { heading, x, y }), do: { heading - amount, x, y}

    defp move({ :forward, amount }, { heading, x, y }) do
        {
            heading,
            x + floor(Float.round(:math.cos(heading * :math.pi / 180)) * amount),
            y + floor(Float.round(:math.sin(heading * :math.pi / 180)) * amount)
        }
    end

    defp direction("N"), do: :north
    defp direction("S"), do: :south
    defp direction("E"), do: :east
    defp direction("W"), do: :west
    defp direction("L"), do: :left
    defp direction("R"), do: :right
    defp direction("F"), do: :forward
end
