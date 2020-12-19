defmodule AdventOfCode2020.Day16TicketTranslation do
    use AdventOfCode2020

    def part_1(input) do
        input
        |> parse
        |> (fn [rules, _your_ticket, other_tickets] ->
            other_tickets
            |> Enum.reduce([], fn ticket, accum -> accum ++ validateTicket(rules, ticket) end)
            |> Enum.sum()
        end).()
    end

    def part_2(input, prefix) do
        input
        |> parse
        |> (fn [rules, your_ticket, other_tickets] ->
            other_tickets
            # filter out tickets that are invalid
            |> Enum.filter(fn ticket -> length(validateTicket(rules, ticket)) <= 0 end)
            |> Enum.zip()
            |> Enum.map(&Tuple.to_list/1)
            |> Enum.map(fn list ->
                Enum.reduce(rules, [], fn rule, acc ->
                    if Enum.all?(list, fn value -> in_ranges(value, rule.ranges) end) do
                        acc ++ [rule.name]
                    else
                        acc
                    end
                end)
            end)
            |> Enum.with_index()

            # sort by number of candidates
            |> Enum.sort(fn { c1, _ }, { c2, _ } -> length(c1) <= length(c2) end)

            # remove candidate field names taken by other columns
            |> Enum.reduce([[], []], fn {candidates, index}, [used, final] ->
                # IO.inspect([used, final])
                newCandidates = candidates -- used
                [used ++ newCandidates, final ++ [{ newCandidates, index }]]
            end)

            # map the first field out
            |> (fn [_, mappings] -> Enum.map(mappings, fn {[first| _], index} -> {first, index} end)  end).()

            # filter to the fields we care about
            |> Enum.filter(fn { field, _ } -> String.starts_with?(field, prefix) end)

            # find the product of the fields on my ticket
            |> Enum.reduce(1, fn {_, index}, accum -> Enum.at(your_ticket, index) * accum end)

        end).()
    end

    defp in_ranges(value, ranges) do
        Enum.any?(ranges, fn range -> Enum.member?(range, value) end)
    end

    defp parse(input) do
        input
        |> String.split("\n\n")
        |> (fn [rules, your_ticket, other_tickets] ->
            rules = parseRules(rules)
            your_ticket = String.replace(your_ticket, "your ticket:\n", "") |> parseTicket()
            other_tickets = other_tickets
                |> String.replace("nearby tickets:\n", "")
                |> String.split("\n")
                |> Enum.map(&parseTicket/1)

            [ rules, your_ticket, other_tickets ]
        end).()
    end

    defp parseRules(rules) do
        rules
        |> String.split("\n")
        |> Enum.map(fn s -> String.split(s, ": ") end)
        |> Enum.map(fn [name, ranges] -> %{
            name: name,
            ranges: String.split(ranges, " or ")
                |> Enum.map(fn range ->
                    String.split(range, "-")
                    |> Enum.map(&String.to_integer/1)
                    |> (fn [first, last] -> Range.new(first, last) end).()
                end)
         } end)
    end

    defp parseTicket(ticket) do
        String.split(ticket, ",")
        |> Enum.map(&String.to_integer/1)
    end

    defp validateTicket(rules, ticket) do
        ticket
        |> Enum.reduce([], fn value, accum ->
            has_match = Enum.any?(rules, fn rule ->
                Enum.any?(rule.ranges, fn range -> Enum.member?(range, value) end)
            end)
            if !has_match do
                accum ++ [value]
            else
                accum
            end
        end)
    end
end
