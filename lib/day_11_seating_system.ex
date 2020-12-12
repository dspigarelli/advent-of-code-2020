defmodule AdventOfCode2020.Day11SeatingSystem do
    use AdventOfCode2020

    def part_1(input) do
        input
        |> parse
        |> buildInitialMap(:next_door)
        |> (fn { map, width, height} -> iterateSeats(map, width, height) end).()
    end

    def part_2(input) do
        input
        |> parse
        |> (fn [first | rest] ->
            { width, height } = { length(first), length(rest) + 1}
            {
                first ++ List.flatten(rest)
                |> Enum.with_index
                |> Enum.filter(fn { x, index } -> x != "." end)
                |> Enum.into(%{}, fn { x, index } -> { index, x } end),
                width,
                height
            }
        end).()
        # |> IO.inspect()
        # |> (fn { map, width, height} ->
        #     printMap2(map, width, height)
        #     { map, width, height }
        # end).()
        |> (fn { map, width, height } -> iterateSeats2(map, width, height, &iterateSeat2/4) end).()
    end

    defp parse(input) do
        input
        |> String.split("\n", trim: true)
        |> Enum.map(&String.graphemes/1)
    end

    defp iterateSeats2(map, width, height, iterateSeatFn) do
        # IO.inspect(map)
        Stream.unfold(
            {true, map, 0},
            fn  { false, _, _ } -> nil
                { _, _, iteration } when iteration > 10000 -> nil
                { true, map, iteration } ->

                    IO.inspect("iteration: #{iteration}")

                    Enum.reduce(
                        map,
                        { false, %{} },
                        fn { index, current }, { hasChanged, newMap } ->
                            newSeat = iterateSeatFn.(map, index, width, height)
                            # IO.inspect("#{index}: #{current} -> #{newSeat}")

                            {
                                hasChanged || newSeat != current,
                                Map.merge(newMap, %{ index => newSeat })
                            }
                        end
                    )
                    # |> (fn { changed, map} ->
                    #     printMap2(map, width, height)
                    #     { changed, map }
                    # end).()
                    |> (fn { changed, newMap} -> { { true, map }, { changed, newMap, iteration+1} } end).()
            end
        )
        # |> Enum.map(fn x -> IO.inspect(x) end)
        |> Enum.map(fn { _, map } ->
            Map.values(map)
            |> Enum.filter(fn
                "#" -> true
                _ -> false
            end)
            |> Enum.count()
            # |> IO.inspect()

        end)
        |> List.last()
    end

    defp iterateSeats(map, width, height) do
        # printMap(map, width, height)

        Stream.unfold(
            { true, map },
            fn  { false, _ } -> nil
                { true, map } -> nil
                Enum.reduce(
                    map,
                    { false, %{} },
                    fn { seat, { current, neighbors } }, { hasChanged, newMap } ->
                        newSeat = iterateSeat(map, seat, current, neighbors)
                        {
                            hasChanged || newSeat != current,
                            Map.merge(newMap, %{ seat => { newSeat, neighbors } })
                        }
                    end
                )
                # |> (fn { changed, map} ->
                #     printMap(map, width, height)
                #     { changed, map }
                # end).()
                |> (fn x -> { { true, map }, x } end).()
            end
        )
        # |> Enum.filter(fn { _, { seat, _ } } -> seat == "#" end)
        |> Enum.map(fn { _, map } ->
            Map.values(map)
            |> Enum.filter(fn
                { "#", _ } -> true
                { _, _ } -> false
            end)
            |> Enum.count()
            # |> IO.inspect()

        end)
        |> List.last()
    end

    defp iterateSeat(map, _, value, neighbors) do
    # defp iterateSeat(map, seat, value, neighbors) do
        # IO.inspect("iterateSeat #{seat} #{value}")
        # IO.inspect(neighbors, charlists: :as_lists )
        Enum.map(neighbors, fn x -> map[x] end)
        |> Enum.filter(fn
            { "#", _ } -> true
            _ -> false
        end)
        # |> IO.inspect()
        |> Enum.count()
        |> (fn 0 -> "#"
            x when x >= 4 -> "L"
            _ -> value
        end).()
        # |> IO.inspect()

        # value
    end

    defp iterateSeat2(map, index, width, height) do
        {y, x} = { Integer.floor_div(index, width), rem(index, height)}
        neighbors = map

        # IO.inspect("GetNeigbors #{x},#{y}")
        seat = [
            getNeighbors(map, width, height, x, y, :right), # right
            getNeighbors(map, width, height, x, y, :left), # left
            getNeighbors(map, width, height, x, y, :down), # down
            getNeighbors(map, width, height, x, y, :up), # up

            getNeighbors(map, width, height, x, y, :upper_left), # upper left
            getNeighbors(map, width, height, x, y, :lower_right), # lower right

            getNeighbors(map, width, height, x, y, :lower_left), # lower left
            getNeighbors(map, width, height, x, y, :upper_right) # upper right
        ]
        |> Enum.filter(fn s -> s end) # number of seats
        |> Enum.count()
        |> (fn 0 -> "#"
            x when x >=5 -> "L"
            ch -> map[y*width + x]
        end).()
    end

    defp getNeighbors(map, width, height, x, y, direction) do

        {xAdj, yAdj} = direction
        |> (fn
            :left -> { -1, 0}
            :right -> { 1, 0}
            :down -> { 0, 1}
            :up -> { 0, -1}
            :upper_left -> { -1, -1 }
            :lower_left -> { -1, 1 }
            :upper_right -> { 1, -1 }
            :lower_right -> { 1, 1 }
        end).()

        # IO.inspect("GetNeighbors #{x},#{y} #{xAdj} #{yAdj}")
        # stream out the pairs in the line
        Stream.unfold(
            { x, y }, # start with the first
            fn
                {nx, ny} when nx < 0 or ny < 0 or nx >= width or ny >= height -> nil # out of range
                {nx, ny} -> { { nx, ny }, { nx + xAdj, ny + yAdj}}
            end
        )
        # |> Enum.map(&IO.inspect/1)
        |> Enum.map(fn {x,y} -> map[y*width + x] end)
        # |> IO.inspect()
        |> Enum.filter(fn x -> x != nil end)
        # |> Enum.map(fn x -> if x == nil do "." else x end end)
        |> (fn [] -> []
            [_ | rest] -> rest
        end).()
        |> (fn nil -> false
            x ->
                cond do
                    List.first(x) == "#" -> true
                    true -> false
                end
        end).()
        # |> (fn [ _ | rest ] ->
        #     IO.inspect(last)
        #     [ first | rest ]
        #     cond do
        #         nil == last -> false
        #         [ "#" | _ ] == last -> true
        #         [ "L" | _ ] == last -> false
        #     end
        # end).() # drop the first
        # |> Enum.reduce(
        #     false,
        #     fn _, true -> true
        #        _, false -> false
        #       "L", _ -> true
        #       "#", _ -> false
        #     end
        # )
        # |> Enum.reduce_while(
        #     false,
        #     fn "#", nil -> {:halt, true}
        #         "L", nil -> {:halt, false}
        #         _, acc -> {:ok, acc}
        #     end
        # )
        # |> (fn [ _ | last] -> last end).()
        # |> Enum.each(&IO.inspect/1)


        # xRg = x..(max(0, min(xRange, width-1)))
        # yRg = y..(max(0, min(yRange, height-1)))
        # IO.inspect(xRg)
        # IO.inspect(yRg)
        # for ix <- xRg, iy <- yRg do
        #     IO.inspect("ix #{ix}, iy #{iy} #{ix * height + iy} #{map[iy*height + ix]}")
        #     map[iy * height + ix]
        # end
        # |> (fn [ _ | last] -> last end).()
        # |> Enum.map(fn x -> if x == nil do "." else x end end)
        # |> Enum.join("")
        # |> Enum.any?(fn x -> x == '#' end)
    end

    defp printMap2(map, width, height) do
        IO.puts("\n#{width}x#{height}")

        for y <- 0..(height-1), x <- 0..(width-1) do
            Map.get(map, y * width + x)
            |> (fn nil -> "."
                x -> x
            end).()
        end
        |> Enum.chunk_every(width)
        |> Enum.map(fn s -> Enum.join(s, "") end)
        |> Enum.join("\n")
        |> IO.puts()

        map
    end

    defp printMap(map, width, height) do
        IO.puts("\n")

        for x <- 0..(width-1), y <- 0..(height-1) do
            Map.get(map, x * width + y)
            |> (fn nil -> "."
                { x, _ } -> x
            end).()
        end
        |> Enum.chunk_every(width)
        |> Enum.map(fn s -> Enum.join(s, "") end)
        |> Enum.join("\n")
        |> IO.puts()

        map
    end

    defp determineNeighbors(x, y, width, height, map) do
        if Enum.at(Enum.at(map, y), x) == "." do
            []
        else
            for i <- -1..1, j <- -1..1 do
                { y+i, x+j }
            end
            |> Enum.filter(fn
                # bounds of map
                {ny, nx} when nx < 0 or ny < 0 or nx > width or ny > height -> false
                # not self
                {ny, nx} when nx == x and ny == y -> false
                {ny, nx} ->
                    # IO.inspect("#{width}x#{height} #{y}:#{x} #{ny}:#{nx} #{Enum.at(map, ny)}")
                    Enum.at(Enum.at(map, ny, []), nx, ".") != "." # neighbor isn't floor space
            end)
            |> Enum.map(fn {y, x} -> y * width + x end) # convert neighbor coordinates
        end
    end

    defp buildInitialMap(map, :next_door) do
        # IO.inspect(map)
        [ first | rest ] = map
        { width, height } = { length(first), length(rest) + 1}
        # IO.inspect("#{width} #{height}")
        for y <- 0..(height-1), x <- 0..(width-1) do
            initial = Enum.at(Enum.at(map, y, []), x)
            # IO.inspect("i: #{y*width+x} #{initial}")
            {
                y * width + x,
                initial,
                if initial == "." do [] else determineNeighbors(x, y, width, height, map) end
            }
        end
        # remove any floor
        |> Enum.filter(fn
            {_, ".", _} -> false
            _ -> true
        end)
        |> Enum.into(%{}, fn {seat, value, neighbors} -> {seat, { value, neighbors } } end)
        |> (fn map -> { map, height, width} end).()
    end
end
