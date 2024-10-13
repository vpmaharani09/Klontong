import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong/presentation/shared/widgets/custom_cupertino_dialog.dart';
import 'package:sliding_sheet_new/sliding_sheet_new.dart';

class SlidingBottomSheet {
  static Future customSlidingBottomSheet<C extends Cubit>(
    BuildContext contextparam, {
    Widget? headerModal,
    Widget? contentModal,
    Widget? footerModal,
    bool isDismissable = true,
    bool usePadding = true,
    double initialSnap = 1,
    List<double> snappings = const [0.0, 1.0],
    C? cubit,
    SheetController? sheetController,
  }) {
    return showSlidingBottomSheet(
      contextparam,
      builder: (context) => SlidingSheetDialog(
        controller: sheetController,
        isDismissable: isDismissable,
        cornerRadius: 24.w,
        snapSpec: SnapSpec(
          initialSnap: initialSnap,
          snappings: snappings,
        ),
        builder: (context, state) => cubit != null
            ? BlocProvider.value(
                value: cubit,
                child: _buildContentModal(
                  contentModal: contentModal,
                  headerModal: headerModal,
                  usePadding: usePadding,
                ),
              )
            : _buildContentModal(
                contentModal: contentModal,
                headerModal: headerModal,
                usePadding: usePadding,
              ),
        footerBuilder: (context, state) => cubit != null
            ? BlocProvider.value(
                value: cubit,
                child: Material(
                  child: footerModal,
                ),
              )
            : Material(
                child: footerModal,
              ),
      ),
    );
  }

  static Widget _buildContentModal({
    Widget? headerModal,
    Widget? contentModal,
    bool usePadding = true,
  }) {
    return Material(
      color: Colors.transparent,
      child: usePadding
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 24.h),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (headerModal != null) ...[
                      headerModal,
                      SizedBox(height: 16.h),
                    ],
                    if (contentModal != null) ...[
                      contentModal,
                    ],
                  ]),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  if (headerModal != null) ...[
                    headerModal,
                    SizedBox(height: 16.h),
                  ],
                  if (contentModal != null) ...[
                    contentModal,
                  ],
                ]),
    );
  }

  static Future customDialogCupertinoDatePicker(
    BuildContext context, {
    required Function(DateTime) onSelectedDate,
    String? headerTitle,
    String? confirmationLabel,
    double? height,
    DateTime? initialValue,
    DateTime? minimumDate,
    DateTime? maximumDate,
  }) {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CustomCupertinoDatePicker(
          headerTitle: headerTitle,
          confirmationLabel: confirmationLabel,
          height: height,
          newDateValue: initialValue,
          onSelectedDate: (val) {
            onSelectedDate(val);
            Navigator.pop(context);
          },
          maximumDate: maximumDate,
          minimumDate: minimumDate,
        );
      },
    );
  }
}
