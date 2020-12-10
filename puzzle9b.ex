defmodule Xmas do
    def validate(numbers) do
        # IO.inspect(numbers)
        { window, [target] } = Enum.take(numbers, 26) |> Enum.split(-1)

        # IO.inspect([window, target], charlists: :as_lists)
        x = for i <- window, j <- window do
            # IO.inspect({i, j, i+j, target, i+j == target}, charlists: :as_lists)
            i + j == target
        end
        |> Enum.any?(fn s -> s end)

        if !x do
            target
        else
            validate(Enum.take(numbers, -(length(numbers)-1)))
        end
    end

    def findRange(numbers, target) do
        Stream.unfold(
            {[List.first(numbers)], 0, 1},
            fn
                {[], _, _} -> nil
                x ->
                    { current, index, length } = x
                    # IO.inspect(current, charlists: :as_lists)
                    # IO.inspect("Sum: #{Enum.sum(current)}", charlists: :as_lists)
                    cond do
                    Enum.sum(current) == target ->
                        # IO.inspect({ List.first(current), List.last(current)}, charlists: :as_lists)
                        nil
                    Enum.sum(current) < target ->
                        next = Enum.slice(numbers, index, length+1)
                        # IO.inspect("Next")
                        # IO.inspect(next, charlists: :as_lists)
                        {x, { next, index, length+1}}
                    true -> {x, { Enum.slice(numbers, index+1, 1), index+1, 1}}
                    end
            end
        )
        |> Enum.reduce(fn {ls, _, _}, acc ->
            Enum.sort(ls)
            |> (fn ls -> List.first(ls) + List.last(ls) end).()
        end)
    end
end

File.read!("input4")
|> String.split("\n", trim: true)
|> Enum.map(fn s ->
    String.trim(s)
    |> String.to_integer()
end)
|> (fn numbers ->
    invalid = Xmas.validate(numbers)

    IO.inspect("First invalid: #{invalid}")

    range = Xmas.findRange(numbers, invalid)
    IO.inspect(range)
end).()
# |> IO.inspect()