defmodule Seating do
    def toBinary(pass) do
        bin = %{"B" => 1, "F" => 0, "R" => 1, "L" => 0 }
        pass
        |> String.replace(~r/[BR]/, "1")
        |> String.replace(~r/[FL]/, "0")
        |> Integer.parse(2)
        |> (fn {s, t} -> s end).()
    end
end

# s
# IO.read(:stdio, :all)
File.read!("input")
|> String.split("\n", trim: true)
|> Enum.map(&String.trim/1)
|> Enum.map(&Seating.toBinary/1)
|> Enum.max()
|> IO.inspect()