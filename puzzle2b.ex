use Bitwise, only_operators: true

s = """
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc
"""

defmodule Policy do
    def checkPolicy(policy, pwd) do
        [cnt, char] = String.split(policy, " ", trim: true)
        [pos1, pos2] = String.split(cnt, "-", trim: true)
            |> Enum.map(&String.to_integer/1)

        # IO.inspect([
        #     [cnt, char],
        #     [pos1, pos2],
        #     [String.at(pwd, pos1), String.at(pwd, pos2)],
        #     pwd
        # ])
        first = char == String.at(pwd, pos1-1)
        second = char == String.at(pwd, pos2-1)

        (first || second) && !(first && second)
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
