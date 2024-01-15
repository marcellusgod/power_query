let
	dataInicial = Date.StartOfMonth(Date.AddMonths(DateTime.LocalNow(),-15)),
	dataFinal = DateTime.LocalNow(), 
	duracao = Duration.TotalHours(dataFinal - dataInicial),
	Fonte = Table.TransformColumnTypes(
		Table.RenameColumns(
			Table.FromList(
				List.DateTimes(dataInicial, duracao, #duration(1,0,0,0)),
				Splitter.SplitByNothing(), 
				null,
				null,
				ExtraValues.Error
			),
			{"Column1", "Data"}
		),
		{"Data", type date} 
	),
	dia = Table.AddColumn(
		Fonte, 
		"Dia",
		each Date.Day([Data]),
		Int64.Type
	),
	mes = Table.AddColumn( 
		dia, 
		"Mes", 
		each Date.Month([Data]),
		Int64.Type
	),
	ano = Table.AddColumn( 
		mes, 
		"Ano",
		each Date.Year([Data]),
		Int64.Type
	),
	diaDaSemana = Table.AddColumn(
		ano,
		"Dia da semana",
		each Date.DayOfWeekName([Data],"pt-BR"),
		type text
	),
	nomeMes = Table.AddColumn( 
		diaDaSemana,
		"Mes do ano",
		each Date.MonthName([Data],"pt-BR"),
		type text
	),
	numDia = Table.AddColumn(
		nomeMes,
		"N° dia", 
		each Date.DayOfWeek([Data], Day.Sunday) + 1, 
		Int64.Type 
	),
	mes_ano = Table.AddColumn(
		numDia,
		"Mes Ano",
		each 
			if [Mes] < 10 then 
				"0" & Number.ToText([Mes]) & "/" & Number.ToText([Ano])
			else 
				Number.ToText([Mes]) & "/" & Number.ToText([Ano]),
		type text
	)
in
	mes_ano
