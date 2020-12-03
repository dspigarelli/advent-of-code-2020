s = """
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc
"""

defmodule Policy do
    def checkPolicy(policy, pwd) do
        [cnt, char] = String.split(policy, " ", trim: true)
        [low, hi] = String.split(cnt, "-", trim: true)
            |> Enum.map(&String.to_integer/1)

        occurrences = pwd |> String.graphemes |> Enum.count(fn(c) -> c == char end)
        IO.inspect([
            [cnt, char],
            [low, hi],
            occurrences,
            pwd
        ])
        occurrences <= hi && occurrences >= low
    end
end

# s
# IO.read(:stdio, :all)
File.read!("input")
|> String.split("\n", trim: true)
|> Enum.map(fn policy -> String.split(policy, ": ", trim: true) end)
|> Enum.map(fn [policy,pwd] -> 
    Policy.checkPolicy(policy, pwd)
    end)
|> Enum.count(fn item -> item == true end)
|> (fn cnt -> IO.inspect("Count #{cnt}") end).()
