# AdventOfCode2020

To run tests continuously:

```
watchexec -c -p -e 'ex,exs,lock' -- mix test
```

To add a new day:

```
pbpaste | mix day.new day_XX_name
```

## Credit
As I learn Elixir using Advent of Code, the following implementations have been super helpful:
- https://github.com/jaminthorns/advent-of-code-2020
- https://github.com/scmx/advent-of-code-2020-elixir