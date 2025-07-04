import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:table_calendar/table_calendar.dart';
import 'gymhub_util.dart';

DateTime kFirstDay = DateTime(1970, 1, 1);
DateTime kLastDay = DateTime(2100, 1, 1);

extension DateTimeExtension on DateTime {
  DateTime get startOfDay => DateTime(year, month, day);

  DateTime get endOfDay => DateTime(year, month, day, 23, 59);
}

class GymHubCalendar extends StatefulWidget {
  const GymHubCalendar({
    super.key,
    required this.color,
    this.onChange,
    this.initialDate,
    this.weekFormat = false,
    this.weekStartsMonday = false,
    this.twoRowHeader = false,
    this.iconColor,
    this.dateStyle,
    this.dayOfWeekStyle,
    this.inactiveDateStyle,
    this.selectedDateStyle,
    this.titleStyle,
    this.rowHeight,
    this.locale,
  });

  final bool weekFormat;
  final bool weekStartsMonday;
  final bool twoRowHeader;
  final Color color;
  final void Function(DateTimeRange?)? onChange;
  final DateTime? initialDate;
  final Color? iconColor;
  final TextStyle? dateStyle;
  final TextStyle? dayOfWeekStyle;
  final TextStyle? inactiveDateStyle;
  final TextStyle? selectedDateStyle;
  final TextStyle? titleStyle;
  final double? rowHeight;
  final String? locale;

  @override
  State<StatefulWidget> createState() => _GymHubCalendarState();
}

class _GymHubCalendarState extends State<GymHubCalendar> {
  late DateTime focusedDay;
  late DateTime selectedDay;
  late DateTimeRange selectedRange;

  @override
  void initState() {
    super.initState();
    focusedDay = widget.initialDate ?? DateTime.now();
    selectedDay = widget.initialDate ?? DateTime.now();
    selectedRange = DateTimeRange(
      start: selectedDay.startOfDay,
      end: selectedDay.endOfDay,
    );
    SchedulerBinding.instance
        .addPostFrameCallback((_) => setSelectedDay(selectedRange.start));
  }

  CalendarFormat get calendarFormat =>
      widget.weekFormat ? CalendarFormat.week : CalendarFormat.month;

  StartingDayOfWeek get startingDayOfWeek => widget.weekStartsMonday
      ? StartingDayOfWeek.monday
      : StartingDayOfWeek.sunday;

  Color get color => widget.color;

  Color get lightColor => widget.color.applyAlpha(0.85);

  Color get lighterColor => widget.color.applyAlpha(0.60);

  void setSelectedDay(
    DateTime? newSelectedDay, [
    DateTime? newSelectedEnd,
  ]) {
    final newRange = newSelectedDay == null
        ? null
        : DateTimeRange(
            start: newSelectedDay.startOfDay,
            end: newSelectedEnd ?? newSelectedDay.endOfDay,
          );
    setState(() {
      selectedDay = newSelectedDay ?? selectedDay;
      selectedRange = newRange ?? selectedRange;
      if (widget.onChange != null) {
        widget.onChange!(newRange);
      }
    });
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CalendarHeader(
            focusedDay: focusedDay,
            onLeftChevronTap: () => setState(
              () => focusedDay = widget.weekFormat
                  ? _previousWeek(focusedDay)
                  : _previousMonth(focusedDay),
            ),
            onRightChevronTap: () => setState(
              () => focusedDay = widget.weekFormat
                  ? _nextWeek(focusedDay)
                  : _nextMonth(focusedDay),
            ),
            onTodayButtonTap: () => setState(() => focusedDay = DateTime.now()),
            titleStyle: widget.titleStyle,
            iconColor: widget.iconColor,
            locale: widget.locale,
            twoRowHeader: widget.twoRowHeader,
          ),
          TableCalendar(
            focusedDay: focusedDay,
            selectedDayPredicate: (date) => isSameDay(selectedDay, date),
            firstDay: kFirstDay,
            lastDay: kLastDay,
            calendarFormat: calendarFormat,
            headerVisible: false,
            locale: widget.locale,
            rowHeight: widget.rowHeight ?? MediaQuery.sizeOf(context).width / 7,
            calendarStyle: CalendarStyle(
              defaultTextStyle:
                  widget.dateStyle ?? const TextStyle(color: Color(0xFF5A5A5A)),
              weekendTextStyle:
                  widget.dateStyle ?? const TextStyle(color: Color(0xFF5A5A5A)),
              holidayTextStyle:
                  widget.dateStyle ?? const TextStyle(color: Color(0xFF5C6BC0)),
              selectedTextStyle:
                  const TextStyle(color: Color(0xFFFAFAFA), fontSize: 16.0)
                      .merge(widget.selectedDateStyle),
              todayTextStyle:
                  const TextStyle(color: Color(0xFFFAFAFA), fontSize: 16.0)
                      .merge(widget.selectedDateStyle),
              outsideTextStyle: const TextStyle(color: Color(0xFF9E9E9E))
                  .merge(widget.inactiveDateStyle),
              selectedDecoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: lighterColor,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: lightColor,
                shape: BoxShape.circle,
              ),
              markersMaxCount: 3,
              canMarkersOverflow: true,
            ),
            availableGestures: AvailableGestures.horizontalSwipe,
            startingDayOfWeek: startingDayOfWeek,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: const TextStyle(color: Color(0xFF616161))
                  .merge(widget.dayOfWeekStyle),
              weekendStyle: const TextStyle(color: Color(0xFF616161))
                  .merge(widget.dayOfWeekStyle),
            ),
            onPageChanged: (focused) {
              if (focusedDay.startOfDay != focused.startOfDay) {
                setState(() => focusedDay = focused);
              }
            },
            onDaySelected: (newSelectedDay, focused) {
              if (!isSameDay(selectedDay, newSelectedDay)) {
                setSelectedDay(newSelectedDay);
                if (focusedDay.startOfDay != focused.startOfDay) {
                  setState(() => focusedDay = focused);
                }
              }
            },
          ),
        ],
      );
}

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({
    super.key,
    required this.focusedDay,
    required this.onLeftChevronTap,
    required this.onRightChevronTap,
    required this.onTodayButtonTap,
    this.iconColor,
    this.titleStyle,
    this.locale,
    this.twoRowHeader = false,
  });

  final DateTime focusedDay;
  final VoidCallback onLeftChevronTap;
  final VoidCallback onRightChevronTap;
  final VoidCallback onTodayButtonTap;
  final Color? iconColor;
  final TextStyle? titleStyle;
  final String? locale;
  final bool twoRowHeader;

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(),
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: twoRowHeader ? _buildTwoRowHeader() : _buildOneRowHeader(),
      );

  Widget _buildTwoRowHeader() => Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(width: 16),
              _buildDateWidget(),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: _buildCustomIconButtons(),
          ),
        ],
      );

  Widget _buildOneRowHeader() => Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const SizedBox(width: 16),
          _buildDateWidget(),
          ..._buildCustomIconButtons(),
        ],
      );

  Widget _buildDateWidget() => Expanded(
        child: Text(
          DateFormat.yMMMM(locale).format(focusedDay),
          style: const TextStyle(fontSize: 17).merge(titleStyle),
        ),
      );

  List<Widget> _buildCustomIconButtons() => <Widget>[
        CustomIconButton(
          icon: Icon(Icons.calendar_today, color: iconColor),
          onTap: onTodayButtonTap,
        ),
        CustomIconButton(
          icon: Icon(Icons.chevron_left, color: iconColor),
          onTap: onLeftChevronTap,
        ),
        CustomIconButton(
          icon: Icon(Icons.chevron_right, color: iconColor),
          onTap: onRightChevronTap,
        ),
      ];
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.margin = const EdgeInsets.symmetric(horizontal: 4),
    this.padding = const EdgeInsets.all(10),
  });

  final Icon icon;
  final VoidCallback onTap;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => Padding(
        padding: margin,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(100),
          child: Padding(
            padding: padding,
            child: Icon(
              icon.icon,
              color: icon.color,
              size: icon.size,
            ),
          ),
        ),
      );
}

DateTime _previousWeek(DateTime week) {
  return week.subtract(const Duration(days: 7));
}

DateTime _nextWeek(DateTime week) {
  return week.add(const Duration(days: 7));
}

DateTime _previousMonth(DateTime month) {
  if (month.month == 1) {
    return DateTime(month.year - 1, 12);
  } else {
    return DateTime(month.year, month.month - 1);
  }
}

DateTime _nextMonth(DateTime month) {
  if (month.month == 12) {
    return DateTime(month.year + 1, 1);
  } else {
    return DateTime(month.year, month.month + 1);
  }
}
