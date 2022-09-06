let
    fxWeekOfCalendar = (Data as date) =>
    let
        Weekday = Date.DayOfWeek(Data) + 1,
        Part1 = Number.From(Data) - Weekday + 11,
        Part2 = Number.From(#date(Date.Year(Date.From(Number.From(Data) + 4 - Weekday)),1,1)),
        Part3 = (Part1 - Part2) / 7,
        Tranc = Part3 - Number.Mod(Part3, 1)
    in
        Tranc
in
    fxWeekOfCalendar