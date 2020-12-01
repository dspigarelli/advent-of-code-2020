IO.read(:stdio, :all)
|> String.split("\n", trim: true)
|> Enum.map(&String.to_integer/1)
|> Enum.with_index
|> (fn list -> 
    list
    |> Enum.each(fn ({x, i}) ->
        for ({y,_}) <- Enum.slice(list, (i+1)..-1) do
            if y+x == 2020 do
                IO.inspect("#{x} + #{y} = #{x+y} #{x*y}")
            end
        end
    end)
end).()

