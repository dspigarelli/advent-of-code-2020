# I solved the first part by precomputing each :empty's neighbors. The code was super icky
# (I'm doing this in Elixir because I want to learn it) and I spent several hours trying to
# solve step two, before finally giving up and looking for some solutions. My solution was
# taking FOREVER to compute, and after sinking a couple hours in, I was done.
#
# The following code is modified from https://github.com/jaminthorns/advent-of-code-2020. I
# learned a lot cribbing the code, such as more about how to use Maps, more on Streams, and
# more on function "overloading" (or matching, whatever it's called). Still slightly mystified
# by the &() syntax, so going to lookup more on that.

defmodule AdventOfCode2020.Day11SeatingSystem do
    use AdventOfCode2020

    @directions List.delete(for(x <- -1..1, y <- -1..1, do: {x,y}), {0,0})

    def part_1(input) do
        input
        |> parse
        |> calculate_equilibrium(4, &adjacent/2)
    end

    def part_2(input) do
        input
        |> parse
        |> calculate_equilibrium(5, &line_of_sight/2)
    end

    defp parse(input) do
        for {line, y} <- input |> String.split() |> Enum.with_index(),
            {symbol, x} <- line |> String.graphemes() |> Enum.with_index(),
            into: %{} do
            {{x,y}, state(symbol)}
        end
    end

    defp calculate_equilibrium(room, tolerance, neighbors) do
        room
        # iterates takes room (piped in) and then continuously calls evolve with the next iteration of the room
        |> Stream.iterate(&evolve(&1, tolerance, neighbors))
        # unwraps the iterator above
        |> Stream.scan({nil, nil}, fn curr, {prev, _} -> {curr, prev} end)
        # did the room evolve?
        |> Enum.find(fn {curr, prev} -> curr == prev end)
        # grab the last room
        |> elem(0)
        # count the number of chairs
        |> occupied()
    end

    defp evolve(room, tolerance, neighbors) do
        Map.new(room, fn {position, state} ->
            # compute indices for neighbors
            neighbors = neighbors.(position, room)
            # grab the neighbors from the map
            occupied = room |> Map.take(neighbors) |> occupied()

            cond do
                state == :empty and occupied == 0 -> { position, :occupied }
                state == :occupied and occupied >= tolerance -> { position, :empty}
                true -> { position, state }
            end
        end)
    end

    defp occupied(room) do
        room
        |> Map.values()
        # buckets the values by type (e.g. number of occupied, etc.)
        |> Enum.frequencies()
        |> Map.get(:occupied, 0)
    end

    defp adjacent({x, y}, room) do
        # compute the coordinates for each neighbor
        Enum.map(@directions, fn {dx, dy} -> {x + dx, y + dy} end)
    end

    defp line_of_sight({x, y}, room) do
        # compute the coordinates for the next line of site
        Enum.map(@directions, fn {dx, dy} ->
            1
            # start at one, and keep iterating incrementally to follow the light of sight
            |> Stream.iterate(&(&1 + 1))
            # go in the intended direction
            |> Stream.map(&{x + dx * &1, y + dy * &1})
            # until we find something that is not a :floor (could be :occupied, :empty, or nil)
            |> Enum.find(&(Map.get(room, &1) != :floor))
        end)
    end

    defp state("."), do: :floor
    defp state("L"), do: :empty
    defp state("#"), do: :occupied
end
