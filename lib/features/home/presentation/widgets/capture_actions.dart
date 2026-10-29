import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transkriptor_uz/core/router/routes.dart';
import 'package:transkriptor_uz/core/widgets/source_icon.dart';
import 'package:transkriptor_uz/features/upload/application/pick_file_cubit.dart';

/// Starts [source]'s flow. The one place that knows where each source
/// leads, shared by the «+» sheet and the home cards. Picking a file needs
/// the shell's [PickFileCubit]; the shell's listener takes the picked file
/// on to the send page.
void startCapture(BuildContext context, CaptureSource source) {
  switch (source) {
    case CaptureSource.upload:
      unawaited(context.read<PickFileCubit>().pick());
    case CaptureSource.youtube || CaptureSource.cloud:
      unawaited(context.push(Routes.link));
    case CaptureSource.recording:
      unawaited(context.push(Routes.record));
    case CaptureSource.dictation:
      unawaited(context.push(Routes.dictation));
    case CaptureSource.screen:
      unawaited(context.push(Routes.screenRecord));
    case CaptureSource.meeting:
      unawaited(context.push(Routes.meeting));
    case CaptureSource.url:
      unawaited(context.push(Routes.url));
    case CaptureSource.note:
      // Notes are not a capture source in this phase.
      break;
  }
}
