IO.read(:stdio, :all)
|> String.split("\n", trim: true)
|> Enum.map(&String.to_integer/1)
|> Enum.with_index
|> (fn list -> 
    list
    |> Enum.each(fn ({x, i}) ->
        for ({y,j}) <- Enum.slice(list, (i+1)..-1) do
            for ({z,_}) <- Enum.slice(list, (j+1)..-1) do
                if y+x+z == 2020 do
                    IO.inspect("#{x} + #{y} + #{z} = #{x+y+z} #{x*y*z}")
                end
            end
        end
    end)
end).()

