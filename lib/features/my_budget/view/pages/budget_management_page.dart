import 'package:budgify/core/theme/app_styles.dart';
import 'package:budgify/shared/view/widgets/global_widgets.dart';
import 'package:budgify/shared/view/widgets/reusable_app_bar.dart';
import 'package:budgify/shared/view/widgets/text_view/reusable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../data/selected_color_contents.dart';
import '../../model/my_budget_model.dart';
import '../../utils/date_time_utils.dart';
import '../../view_model/riverpod/my_budget_notifier.dart';

class BudgetManagementPage extends ConsumerStatefulWidget {
  final MyBudgetModel? myBudgetModel;

  const BudgetManagementPage({super.key, this.myBudgetModel});

  @override
  ConsumerState<BudgetManagementPage> createState() =>
      _BudgetManagementPageState();
}

class _BudgetManagementPageState extends ConsumerState<BudgetManagementPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    updatePage();
  }

  ///If we are in the update mode, we need to update the page with the data
  void updatePage() {
    if (widget.myBudgetModel != null) {
      titleController.text = widget.myBudgetModel!.title;
      descriptionController.text = widget.myBudgetModel!.description;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(myBudgetProvider.notifier)
            .setSelectedColor(widget.myBudgetModel!.color);
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var selectedColor = ref.watch(selectedColorProvider);
    // var selectedColorRProvider = ref.read(selectedColorProvider.notifier);
    final notifier = ref.read(myBudgetProvider.notifier);
    final state = ref.watch(myBudgetProvider); // ✔ UI rebuilds
    final dateTimeString = formatDateTimeNow();

    /// Save or Update Logic
    Future<void> onSave([bool isBackButton = true]) async {
      final title = titleController.text.trim();
      final desc = descriptionController.text.trim();

      if (title.isEmpty && desc.isEmpty) {
        if (isBackButton) {
          Navigator.pop(context);
        }
        else {
          IconSnackBar.show(context,
              label: "Both title & description are empty!",
              snackBarType: SnackBarType.alert);
        }
        return;
      }

      /// In both add and update mode, current date is used to save in database.
      /// If we are in the update mode
      if (widget.myBudgetModel != null) {
       await notifier.updateData(
            id: widget.myBudgetModel!.id!,
            title: titleController.text,
            color: state.selectedColor,
            description: desc,
            date: dateTimeString);
      } else {
        /// If we are in the add mode
      await notifier.addData(
          title: title,
          date: dateTimeString,
          color: state.selectedColor,
          description: desc,
        );
      }
      if (context.mounted) {
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: ReusableAppBar(
        onPressedBackButton: onSave,
        text: "Budget Management",
        isCenterText: false,
      ),
      backgroundColor: state.selectedColor,
      body: WillPopScope(
        // prevent automatic framework pop
        onWillPop: () async{
          await onSave();  // let your onSave decide when to pop

          return Future.value(true);
        },
        child: SingleChildScrollView(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ✓ SAVE BUTTON
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 10, bottom: 2),
              child: InkWell(
                  onTap: () =>  onSave(false),
                  child: FaIcon(
                    FontAwesomeIcons.check,
                    size: 30,
                    color: Colors.black,
                  )),
            ),
          ),

          SizedBox(
            height: 65,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: selectedColorContents(notifier).length,
                itemBuilder: (_, index) {
                  final item = selectedColorContents(notifier)[index];
                  return GestureDetector(
                    onTap: item.onTap,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Card(
                        elevation: 4,
                        shape: const CircleBorder(),
                        child: Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: item.color,
                            border: Border.all(
                              color: state.selectedColor == item.color
                                  ? Colors.black
                                  : Colors.white,
                              width: 2,
                            ),
                            // borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          spacerH(),

          ///It shows previous date if we are in the update mode but if we are in the add mode it shows current date
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
            child: Text(
                widget.myBudgetModel != null
                    ? widget.myBudgetModel!.date
                    : dateTimeString,
                style: AppStyles.descriptionPrimary(
                    context: context, color: Colors.black, fontSize: 15)),
          ),
          spacerH(10),
          ReusableTextField(
            controller: titleController,
            hintText: "Heading",
            isBorder: false,
            maxLines: null,
            isHeading: true,
            keyboardType: TextInputType.multiline,
            filled: false,
          ),
          spacerH(20),
          ReusableTextField(
            controller: descriptionController,
            hintText: "Description",
            maxLines: null,
            isBorder: false,
            keyboardType: TextInputType.multiline,
            filled: false,
          )
        ],
      ),
    ),)
    ,
    // floatingActionButton: Consumer(
    //   builder: (context, ref, child) => ReusableFloatingActionButton(
    //       onTap: () {
    //         if (titleController.text.isEmpty &&
    //             descriptionController.text.isEmpty) {
    //           IconSnackBar.show(context,
    //               label: "Both title & description are empty!",
    //               snackBarType: SnackBarType.alert);
    //           return;
    //         }
    //
    //         /// In both add and update mode, current date is used to save in database.
    //         /// If we are in the update mode
    //         if (widget.myBudgetModel != null) {
    //           rProvider.updateData(
    //               id: widget.myBudgetModel!.id!,
    //               title: titleController.text,
    //               color: selectedColor,
    //               description: descriptionController.text,
    //               date: dateTimeString);
    //         } else {
    //           /// If we are in the add mode
    //           rProvider.addData(
    //               color: selectedColor,
    //               title: titleController.text,
    //               date: dateTimeString,
    //               description: descriptionController.text);
    //         }
    //         Navigator.pop(context);
    //       },
    //       icon: Icons.save,
    //       colors: AppGradients.skyBlueMyAppGradient),
    // ),
    );
  }
}
