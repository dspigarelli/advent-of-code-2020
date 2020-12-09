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
            IO.inspect("No match for #{target}")
            target
        else
            validate(Enum.take(numbers, -(length(numbers)-1)))
        end
    end
end
File.read!("input")
|> String.split("\n", trim: true)
|> Enum.map(fn s -> 
    String.trim(s)
    |> String.to_integer()
end)
|> Xmas.validate()
|> IO.inspect()