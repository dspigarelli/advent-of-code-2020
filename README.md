# AdventOfCode2020

To run tests continuously:

```
watchexec -c -p -e 'ex,exs,lock' -- mix test
```

To add a new day:

```
pbpaste | mix day.new day_XX_name
```