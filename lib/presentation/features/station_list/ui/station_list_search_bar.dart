import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_flux/core/color/color_palette.dart';
import 'package:green_flux/core/constants/constants.dart';
import 'package:green_flux/core/constants/text_styles.dart';
import 'package:green_flux/presentation/features/station_list/logic/state_stations_provider.dart';

class StationListSearchBar extends ConsumerStatefulWidget {
  const StationListSearchBar({super.key});

  @override
  ConsumerState<StationListSearchBar> createState() => _StationListSearchBarState();
}

class _StationListSearchBarState extends ConsumerState<StationListSearchBar> {
  late TextEditingController _searchController;

  Color get _bgColor => ref.watch(stateStationsProvider).when(
        idle: () => ColorPalette.secondary,
        loading: () => ColorPalette.description,
        error: (_) => ColorPalette.errorRed,
        data: (_) => ColorPalette.description,
      );

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: _bgColor,
      duration: const Duration(milliseconds: 500),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ColorPalette.gray200),
              color: ColorPalette.gray50,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: false,
                      hintStyle: TextStyles.body2,
                      hintText: Constants.textSearchLocation,
                    ),
                    onChanged: (newSearch) => ref
                        .read(stateStationsProvider.notifier)
                        .onNewTextSearched(newSearch),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      ref.read(stateStationsProvider.notifier).onSearch(_searchController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(Constants.textSearch, style: TextStyles.body1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
