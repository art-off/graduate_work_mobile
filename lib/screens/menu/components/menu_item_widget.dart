import 'package:flutter/material.dart';
import 'package:graduate_work/arch/utils.dart';
import 'package:graduate_work/widgets/common/options_selection/options_to_position_item_widget.dart';
import 'package:provider/provider.dart';

import '../../../models/menu_item.dart';
import '../../../models/option_item.dart';
import '../../../providers/colors_provider.dart';
import '../../../widgets/custom/src/clipped_container.dart';
import '../../../widgets/standard/src/text.dart';

class MenuItemWidget extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String imageUrl;
  final List<OptionItem>? options;
  final Widget? replacingDescriptionWidget;

  const MenuItemWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.options,
    this.replacingDescriptionWidget,
  }) : super(key: key);

  factory MenuItemWidget.fromModel(
    MenuItem model, {
    Widget? replacingDescriptionWidget,
    List<OptionItem>? options,
  }) {
    return MenuItemWidget(
      title: model.name,
      description: model.description,
      price: defaultPriceFormat.format(model.price),
      imageUrl: model.imageUrl,
      options: options,
      replacingDescriptionWidget: replacingDescriptionWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorSet = context.watch<ColorsProvider>().colorSet;

    return ClipperContainer(
      color: colorSet.content,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: colorSet.separator, width: 0.2),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: 96,
                height: 96,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: StandardText(title,
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ))),
                          const SizedBox(width: 10),
                          StandardText(
                            price,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      (replacingDescriptionWidget != null)
                          ? replacingDescriptionWidget!
                          : StandardText(description, maxLines: 3),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (options != null && options!.isNotEmpty)
            OptionsToPositionItemWidget(options: options!),
        ],
      ),
    );
  }
}
