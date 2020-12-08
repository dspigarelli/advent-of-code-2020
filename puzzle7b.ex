defmodule Baggage do
    def parseRule(rule) do
        # IO.inspect("#{rule}")
        sansBags = String.replace(rule, ~r/ bags?/, "", global: true)
        [container, containee] = String.split(sansBags, " contain ")
        containees = String.split(containee, ", ")
        |> Enum.map(fn s -> String.replace(s, ~r/\.$/, "") end)
        |> Enum.map(fn s -> Regex.run(~r/^(\d+) (.*)$/, s) end)
        |> Enum.filter(fn x -> x != nil end)
        |> Enum.map(fn [_, countStr, bag] -> { String.to_integer(countStr), bag } end)
        # IO.inspect({container, containees})
        {container, containees}
    end

    def expandBags(rules, emptyBags, nonEmptyBags) do
        { newEmptyBags, stillNotEmpty } = Enum.reduce(
            nonEmptyBags,
            {emptyBags, []}, # current emptied bags, and still not empty bags
            fn {count, bag}, {newlyEmptyBags, stillNotEmpty} ->
                childBags = Map.fetch!(rules, bag)
                { newlyEmptyBags ++ List.duplicate(bag, count), stillNotEmpty ++ Enum.flat_map(childBags, fn x -> List.duplicate(x, count) end) }
            end
        )
        IO.inspect("Bag Total (so far): #{length(newEmptyBags)-1}")

        if length(stillNotEmpty) == 0 do
            length(newEmptyBags)
        else
            expandBags(rules, newEmptyBags, stillNotEmpty)
        end
    end
end

# s
# IO.read(:stdio, :all)
File.read!("input3")
|> String.split("\n")
|> Enum.map(&String.trim/1)
|> Enum.map(&Baggage.parseRule/1)
|> Enum.into(%{})
|> Baggage.expandBags([], [{1, "shiny gold"}])
# |> Enum.map(&Seating.toBinary/1)
# |> Enum.sort()
# |> Enum.reduce(0, fn x, acc ->
#     cond do
#         acc == 0 -> x
#         x == (acc+1) -> x
#         :true -> acc
#     end
# end)
# |> (fn s -> IO.inspect(s+1) end).()
# |> IO.inspect