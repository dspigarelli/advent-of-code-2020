File.read!("input2")
|> String.split("\n", trim: true)
|> Enum.map(fn s ->
    String.split(s, " ", trim: true)
    |> (fn [instruction, operand] -> [instruction, String.to_integer(operand), false] end).()
end )
|> (fn instructions ->
    IO.inspect(instructions)
    Stream.run(Stream.unfold(
        { instructions, 0, 0 },   # accumulator, instruction index
        fn n ->
            { instructions, accum, index } = n
            [instruction, operand, visited ] = Enum.at(instructions, index)
            IO.inspect("====> Instruction #{instruction} op #{operand} accum #{accum} index #{index} #{visited}")
            cond do
            visited ->
                    IO.inspect("Accum: #{accum}")
                    nil
            true ->
                [ head, target, tail ] = Enum.split(instructions, index)
                |> (fn {head, tail} ->
                    # IO.inspect("head/tail")
                    # IO.inspect({head, tail})
                    [ target, tail ] = Tuple.to_list(Enum.split(tail, 1))
                    [head, target, tail]
                end).()

                # IO.inspect([head, target, tail])
                # { first, middle, rest } = cond do
                #     index == 0 -> { [], [instruction, operand, true], Enum.slice(instructions, 1..-1) }
                #     index == length(instructions) -> { Enum.slice(instructions, 0..(index-1)), [instruction, operand, true], [] }
                #     true -> { Enum.slice(instructions, 0..index), [instruction, operand, true], Enum.slice(instructions, index..-1) }
                # end
                # IO.inspect(first ++ [middle] ++ rest)

                [newAccum, newIndex] = cond do
                    instruction == "acc" -> [accum + operand, index + 1]
                    instruction == "nop" -> [accum, index + 1]
                    instruction == "jmp" -> [accum, index + operand]
                    true -> accum
                end

                { n, { head ++ [[ instruction, operand, true]] ++ tail, newAccum, newIndex } }
            end
        end
    ))
end).()
# |> Program.execute(0)
# |> Enum.map(fn s ->
#     String.replace(s, ~r/\n/, "")
#     |> String.graphemes
#     |> Enum.uniq
#     |> Enum.count
# end)
# |> Enum.reduce(0, fn item, acc -> acc + item end)
|> IO.inspect()