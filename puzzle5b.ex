defmodule Seating do
    def toBinary(pass) do
        pass
        |> String.replace(~r/[BR]/, "1")
        |> String.replace(~r/[FL]/, "0")
        |> Integer.parse(2)
        |> (fn {s, _} -> s end).()
    end
end

# s
# IO.read(:stdio, :all)
File.read!("input")
|> String.split("\n", trim: true)
|> Enum.map(&String.trim/1)
|> Enum.map(&Seating.toBinary/1)
|> Enum.sort()
|> Enum.reduce(0, fn x, acc -> 
    cond do 
        acc == 0 -> x
        x == (acc+1) -> x
        :true -> acc
    end
end)
|> (fn s -> IO.inspect(s+1) end).()