import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong/core/core.dart';
import 'package:klontong/data/models/models.dart';
import 'package:klontong/gen/assets.gen.dart';
import 'package:klontong/gen/colors.gen.dart';
import 'package:klontong/presentation/presentation.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateProductCubit, CreateProductState>(
          listener: (context, state) {
            if (state.filePickerResult.status.isError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: ColorName.pink,
                  showCloseIcon: true,
                  closeIconColor: ColorName.red,
                  content: Text(
                    state.filePickerResult.message,
                    style: AppTextStyle.textStyleMedium14Fw400(
                      color: ColorName.red,
                    ),
                  ),
                ),
              );
            }

            if (state.response.status.isError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: ColorName.pink,
                  showCloseIcon: true,
                  closeIconColor: ColorName.red,
                  content: Text(
                    state.response.message,
                    style: AppTextStyle.textStyleMedium14Fw400(
                      color: ColorName.red,
                    ),
                  ),
                ),
              );
            }

            if (state.response.status.isHasData) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: ColorName.primary,
                  showCloseIcon: true,
                  closeIconColor: Colors.white,
                  content: Text(
                    state.isEdit
                        ? 'Update product is success!'
                        : 'Create product is success!',
                    style: AppTextStyle.textStyleMedium14Fw400(
                      color: Colors.white,
                    ),
                  ),
                ),
              );

              Navigator.pop(context, true);
            }
          },
        )
      ],
      child: Stack(
        children: [
          GestureDetector(
            onTap: FocusScope.of(context).unfocus,
            child: Scaffold(
              bottomNavigationBar: Container(
                padding: EdgeInsets.only(
                  bottom: 40.h,
                  left: 15.w,
                  right: 15.w,
                ),
                color: ColorName.white50,
                child: _klontongButton(),
              ),
              backgroundColor: ColorName.offWhite,
              appBar: AppBar(
                backgroundColor: ColorName.bluePastel,
                title: _appbarTitle(),
                leading: Row(
                  children: [
                    SizedBox(
                      width: 16.w,
                    ),
                    Transform.scale(
                      scaleX: -1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Assets.icons.icChevronRight.svg(
                          width: 10.w,
                          color: ColorName.primary,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              body: ListView(
                padding: EdgeInsets.all(20.w),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextLabel(
                        label: 'Product Image',
                        isRequired: true,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      BlocSelector<CreateProductCubit, CreateProductState,
                          String>(
                        selector: (state) => state.imageUrl,
                        builder: (context, imgUrl) {
                          final imgBytes = base64Decode(imgUrl);
                          return Container(
                            width: double.infinity,
                            height: 160.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(
                                color: ColorName.borderTextfield,
                              ),
                              image: imgUrl.isEmpty
                                  ? null
                                  : DecorationImage(
                                      image: Image.memory(imgBytes).image,
                                    ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    KlontongDialog.showSimpleActionBottomSheet(
                                      context,
                                      onNegative: () {
                                        Navigator.pop(context);
                                      },
                                      body: PickImageDialog(
                                        onClickCamera: () {
                                          context
                                              .read<CreateProductCubit>()
                                              .pickImage(
                                                  source:
                                                      SourceImageEnum.camera);
                                        },
                                        onClickGallery: () {
                                          context
                                              .read<CreateProductCubit>()
                                              .pickImage(
                                                  source:
                                                      SourceImageEnum.gallery);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    padding: EdgeInsets.all(6.w),
                                    child: ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 2,
                                          sigmaY: 2,
                                        ),
                                        child: Icon(
                                          Icons.add_rounded,
                                          size: 30.w,
                                          color: ColorName.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  _nameField(),
                  _descField(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 7,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: _quantityField(),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  flex: 4,
                                  child: _unitDropdown(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            flex: 3,
                            child: _stockField(),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextLabel(label: 'Price', isRequired: true),
                            SizedBox(
                              height: 4.h,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 46.h,
                              decoration: BoxDecoration(
                                color: ColorName.backgroundTextfield,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                '\$',
                                style: AppTextStyle.textStyleBold16Fw400(
                                  color: ColorName.textSecondary,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        flex: 8,
                        child: _priceField(),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextLabel(label: 'Expired Date', isRequired: true),
                      SizedBox(
                        height: 4.h,
                      ),
                      BlocSelector<CreateProductCubit, CreateProductState,
                          DateTime?>(
                        selector: (state) => state.expiredDate?.startOfDay(),
                        builder: (context, selectedDate) {
                          return GestureDetector(
                            onTap: () {
                              SlidingBottomSheet
                                  .customDialogCupertinoDatePicker(
                                context,
                                headerTitle: 'Expired Date',
                                onSelectedDate: (value) {
                                  context
                                      .read<CreateProductCubit>()
                                      .onChangeDateTime(value);
                                },
                                initialValue:
                                    selectedDate ?? DateTime.now().startOfDay(),
                                minimumDate: DateTime.now().startOfDay(),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 46.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorName.borderTextfield,
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: Text(
                                        selectedDate == null
                                            ? 'Select date'
                                            : DateTimeUtils.formatDateIndo(
                                                selectedDate,
                                              ),
                                        style:
                                            AppTextStyle.textStyleMedium13Fw400(
                                          color: ColorName.textSecondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    color: ColorName.hintColor,
                                    size: 20.w,
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ].fold(
                    [],
                    (previousValue, element) => [
                          ...previousValue,
                          ...[
                            if (previousValue.isNotEmpty)
                              SizedBox(
                                height: 20.h,
                              ),
                            element
                          ],
                        ]),
              ),
            ),
          ),
          _generateLoading(),
        ],
      ),
    );
  }

  Widget _appbarTitle() {
    return BlocSelector<CreateProductCubit, CreateProductState, bool>(
        selector: (state) => state.isEdit,
        builder: (context, isEdit) {
          return Text(
            isEdit ? 'Update Product' : 'Create Product',
            style: AppTextStyle.textStyleBold18Fw400(
              color: ColorName.primary,
            ),
          );
        });
  }

  Widget _generateLoading() {
    return BlocSelector<CreateProductCubit, CreateProductState, bool>(
        selector: (state) => state.response.status.isLoading,
        builder: (context, isLoading) {
          return Visibility(
            visible: isLoading,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: const Center(
                child: CircularProgressIndicator(
                  color: ColorName.primary,
                ),
              ),
            ),
          );
        });
  }

  Widget _priceField() {
    return BlocSelector<CreateProductCubit, CreateProductState, String>(
        selector: (state) => state.price.toString(),
        builder: (context, price) {
          return LabelWithTextField(
            label: '',
            hintText: '0',
            fieldName: 'price',
            onChanged: context.read<CreateProductCubit>().onChangePrice,
            keyboardType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter()],
            initialValue: price,
          );
        });
  }

  Widget _stockField() {
    return BlocSelector<CreateProductCubit, CreateProductState, String>(
        selector: (state) => state.stock.toString(),
        builder: (context, stock) {
          return LabelWithTextField(
            label: 'Stock',
            hintText: '0',
            fieldName: 'stock',
            keyboardType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter()],
            onChanged: context.read<CreateProductCubit>().onChangeStock,
            isRequiredField: true,
            initialValue: stock,
          );
        });
  }

  Widget _unitDropdown() {
    return BlocSelector<CreateProductCubit, CreateProductState, String>(
        selector: (state) => state.unitDisplay,
        builder: (context, unit) {
          return KlontongDropdownButton<String>(
            items: UnitDisplayEnum.values
                .map(
                  (e) => DropdownMenuItem(
                    value: e.name,
                    child: Text(
                      e.name,
                      style: AppTextStyle.textStyleMedium14Fw400(
                        color: ColorName.textSecondary,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: context.read<CreateProductCubit>().onChangeUnit,
            value: unit,
          );
        });
  }

  Widget _quantityField() {
    return BlocSelector<CreateProductCubit, CreateProductState, String>(
        selector: (state) => state.quantity.toString(),
        builder: (context, quantity) {
          return LabelWithTextField(
            label: 'Quantity',
            hintText: '0',
            fieldName: 'quantity',
            keyboardType: TextInputType.number,
            onChanged: context.read<CreateProductCubit>().onChangeQuantity,
            isRequiredField: true,
            initialValue: quantity,
            inputFormatters: [
              CurrencyInputFormatter(),
            ],
          );
        });
  }

  Widget _descField() {
    return BlocSelector<CreateProductCubit, CreateProductState, String>(
        selector: (state) => state.description,
        builder: (context, description) {
          return LabelWithTextField(
            label: 'Description',
            isRequiredField: true,
            hintText: 'Enter the description of the product',
            fieldName: 'desc',
            onChanged: context.read<CreateProductCubit>().onChangeDesc,
            maxLines: 5,
            maxLength: 500,
            initialValue: description,
          );
        });
  }

  Widget _nameField() {
    return BlocSelector<CreateProductCubit, CreateProductState, String>(
        selector: (state) => state.name,
        builder: (context, name) {
          return LabelWithTextField(
            label: 'Product name',
            hintText: 'Enter the product name',
            fieldName: 'name',
            isRequiredField: true,
            onChanged: context.read<CreateProductCubit>().onChangeName,
            initialValue: name,
          );
        });
  }

  Widget _klontongButton() {
    return BlocSelector<CreateProductCubit, CreateProductState,
            Pair<bool, bool>>(
        selector: (state) => Pair(state.isEdit, state.isValid),
        builder: (context, state) {
          return KlontongCustomButton(
            backgroundColor: ColorName.primary,
            splashColor: ColorName.textPrimary,
            title: state.first ? 'Update Product' : 'Create Product',
            borderRadius: BorderRadius.circular(16.r),
            onTap: context.read<CreateProductCubit>().submitProduct,
            enabled: state.second,
          );
        });
  }
}
