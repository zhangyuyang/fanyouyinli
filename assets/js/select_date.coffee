(($) ->
  $.extend ms_DatePicker: (options) ->
    
    # 初始化
    
    # 年份列表
    
    # 月份列表
    
    # 日列表(仅当选择了年月)
    BuildDay = ->
      if $YearSelector.val() is 0 or $MonthSelector.val() is 0
        
        # 未选择年份或者月份
        $DaySelector.html str
      else
        $DaySelector.html str
        year = parseInt($YearSelector.val())
        month = parseInt($MonthSelector.val())
        dayCount = 0
        switch month
          when 1, 3, 5, 7, 8, 10, 12
            dayCount = 31
          when 4, 6, 9, 11
            dayCount = 30
          when 2
            dayCount = 28
            dayCount = 29  if (year % 4 is 0) and (year % 100 isnt 0) or (year % 400 is 0)
          else
        i = 1

        while i <= dayCount
          dayStr = "<option value=\"" + i + "\">" + i + "</option>"
          $DaySelector.append dayStr
          i++
      return
    defaults =
      YearSelector: "#sel_year"
      MonthSelector: "#sel_month"
      DaySelector: "#sel_day"
      FirstText: "--"
      FirstValue: 0

    opts = $.extend({}, defaults, options)
    $YearSelector = $(opts.YearSelector)
    $MonthSelector = $(opts.MonthSelector)
    $DaySelector = $(opts.DaySelector)
    FirstText = opts.FirstText
    FirstValue = opts.FirstValue
    str = "<option value=\"" + FirstValue + "\">" + FirstText + "</option>"
    $YearSelector.html str
    $MonthSelector.html str
    $DaySelector.html str
    yearNow = new Date().getFullYear()
    i = yearNow

    while i >= 1900
      yearStr = "<option value=\"" + i + "\">" + i + "</option>"
      $YearSelector.append yearStr
      i--
    i = 1

    while i <= 12
      monthStr = "<option value=\"" + i + "\">" + i + "</option>"
      $MonthSelector.append monthStr
      i++
    $MonthSelector.change ->
      BuildDay()
      return

    $YearSelector.change ->
      BuildDay()
      return

    return

  return
# End ms_DatePicker
) jQuery