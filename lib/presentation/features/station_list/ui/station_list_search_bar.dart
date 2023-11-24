import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_flux/core/color/color_palette.dart';
import 'package:green_flux/core/constants/text_styles.dart';
import 'package:green_flux/presentation/features/station_list/logic/state_stations_provider.dart';

class StationListSearchBar extends ConsumerWidget {
  StationListSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          width: double.infinity,
          // height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorPalette.gray200),
            color: ColorPalette.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: TextField(
                  maxLengthEnforcement: MaxLengthEnforcement.none,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: false,
                    hintStyle: TextStyles.body2,
                    hintText: "Search location",
                  ),
                  onChanged: (newSearch) => ref
                      .read(stateStationsProvider.notifier)
                      .onNewTextSearched(newSearch),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Search", style: TextStyles.body1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
