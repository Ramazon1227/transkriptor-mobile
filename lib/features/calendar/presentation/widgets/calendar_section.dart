import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transkriptor_uz/core/l10n/l10n.dart';
import 'package:transkriptor_uz/core/theme/app_colors.dart';
import 'package:transkriptor_uz/core/theme/app_text.dart';
import 'package:transkriptor_uz/core/theme/app_theme.dart';
import 'package:transkriptor_uz/core/utils/formatters.dart';
import 'package:transkriptor_uz/core/widgets/section_header.dart';
import 'package:transkriptor_uz/features/calendar/application/calendar_cubit.dart';
import 'package:transkriptor_uz/features/calendar/domain/entities/calendar_event.dart';

/// How many upcoming meetings the home screen lists.
const int _shown = 3;

/// «Kalendar» on the home screen: the next meetings from Google Calendar,
/// or one line saying it is connected on the web.
class CalendarSection extends StatelessWidget {
  const CalendarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(title: l10n.homeCalendar),
        const SizedBox(height: 4),
        BlocBuilder<CalendarCubit, CalendarState>(
          builder: (context, state) => switch (state.status) {
            CalendarStatus.initial || CalendarStatus.loading => const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            ),
            CalendarStatus.failure => _Line(state.failure!.message(l10n)),
            CalendarStatus.notConnected => _Line(l10n.calendarNotConnected),
            CalendarStatus.empty => _Line(l10n.calendarEmpty),
            CalendarStatus.success => Column(
              children: [
                for (final e in state.events.take(_shown)) ...[
                  _EventRow(event: e),
                  const SizedBox(height: 8),
                ],
              ],
            ),
          },
        ),
      ],
    );
  }
}

class _Line extends StatelessWidget {
  const _Line(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(text, style: AppText.caption),
  );
}

class _EventRow extends StatelessWidget {
  const _EventRow({required this.event});

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final start = event.startsAt;
    final now = DateTime.now();
    final when = start == null
        ? ''
        : DateUtils.isSameDay(start, now)
        ? l10n.calendarToday(Formatters.clock(start))
        : '${Formatters.date(start)} · ${Formatters.clock(start)}';
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.sf1,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Row(
        children: [
          Icon(
            event.joinUrl.isEmpty
                ? Icons.event_outlined
                : Icons.video_camera_front_outlined,
            color: AppColors.mutedDark,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.bodyMedium,
                ),
                if (when.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(when, style: AppText.mono),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
