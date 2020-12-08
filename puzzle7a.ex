defmodule Baggage do
    def parseRule(rule) do
        sansBags = String.replace(rule, ~r/ bags?/, "", global: true)
        [container, containee] = String.split(sansBags, " contain ")
        containees = String.split(containee, ", ")
        |> Enum.map(fn s -> String.replace(s, ~r/\.$/, "") end)
        |> Enum.map(fn s -> String.replace(s, ~r/\d+ /, "", global: true) end)
        |> Enum.filter(fn x -> x != "no other" end)
        # IO.inspect([container, containees])
        [container, containees]
    end

    def walkRules(rules, target) do
        Stream.run(Stream.unfold(
            { rules, [target] },
            fn { rules, targets } ->
                # IO.inspect("Rules:")
                # IO.inspect(rules)
                # IO.inspect("Targets:")
                # IO.inspect(targets)
                { matches, newRules } = Enum.split_with(
                    rules,
                    fn [_, containees] -> Enum.any?(targets, fn x -> Enum.member?(containees, x) end) end
                )
                newTargets = Enum.uniq(Enum.map(matches, fn [first, _] -> first end) ++ targets)
                # IO.inspect("Matches")
                # IO.inspect(newTargets)
                # IO.inspect("New Rules")
                # IO.inspect(newRules)
                IO.inspect("#{length(newTargets)}")

                cond do
                    length(matches) == 0 ->
                        nil
                    true ->
                        { newRules, { newRules, newTargets }}
                end
            end
        ))
    end
end

# s
# IO.read(:stdio, :all)
File.read!("input")
|> String.split("\n")
|> Enum.map(&String.trim/1)
|> Enum.map(&Baggage.parseRule/1)
|> Baggage.walkRules("shiny gold")
