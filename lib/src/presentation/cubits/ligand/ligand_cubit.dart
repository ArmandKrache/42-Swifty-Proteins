import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:swifty_proteins/src/config/config.dart';
import 'package:swifty_proteins/src/data/parsing/parser.dart';
import 'package:swifty_proteins/src/domain/models/ligand/ligand.dart';
import 'package:swifty_proteins/src/domain/repositories/api_repository.dart';
import 'package:swifty_proteins/src/presentation/cubits/base/base_cubit.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:swifty_proteins/src/utils/resources/data_state.dart';
import 'package:swifty_proteins/src/utils/resources/functions.dart';

part 'ligand_state.dart';

class LigandCubit extends BaseCubit<LigandState, Ligand?> {
  final ApiRepository _apiRepository;
  Ligand? ligand;

  LigandCubit(this._apiRepository) : super(const LigandLoading(), null);


  Future<void> getLigand(String id) async {
    if (isBusy) return;
    emit(LigandLoading(ligand: ligand,));

    final response =
      await _apiRepository.getLigand(id);

    if (response is DataSuccess) {
      //logger.d(response.data);
      try {
        ligand = parseRawData(response.data);
        emit(LigandSuccess(ligand: ligand,));
      } catch (e) {
        displayErrorToast(tr("errors.ligand_parse_failed"));
        emit(LigandFailed(exception: response.exception,));
      }
    } else if (response is DataFailed) {
      logger.d(response.exception);
      displayErrorToast(tr("errors.ligand_fetch_failed"));
      emit(LigandFailed(exception: response.exception,));
    }
    return;
  }

  Future<void> captureAndShare(GlobalKey globalKey) async {
    emit(LigandScreenshotLoading(ligand: ligand));
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/screenshot.png').writeAsBytes(pngBytes);
      await file.writeAsBytes(pngBytes);

      XFile xfile = XFile(file.path, name: "file");
      await Share.shareXFiles([xfile]);
      emit(LigandScreenshotSuccess(ligand: ligand));
    } catch (e) {
      logger.d('Error sharing screenshot: $e');
      displayErrorToast(tr("errors.sharing_screenshot_error"));
      emit(LigandScreenshotFailed(ligand: ligand));
    }
  }
}
