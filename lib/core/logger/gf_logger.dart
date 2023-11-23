import 'package:flutter/cupertino.dart';
import 'package:green_flux/core/handlers/env_handler.dart';
import 'package:logger/logger.dart';

class GfLogger{
  static const _appName = "GreenFlux";
  static final Logger _logger = Logger(output: _CustomOutPut(_CustomConsoleOutPut()));

  static void logWarning(String msg){
    if(EnvHandler.instance.isDevEnv){
      final finalMsg = _createLogMessage(msg, Level.warning);
      _logger.w(finalMsg);
    }
  }

  static void logError(String msg){
    if(EnvHandler.instance.isDevEnv){
      final finalMsg = _createLogMessage(msg, Level.error);
      _logger.e(finalMsg);
    }
  }

  static void logInfo(String msg){
    if(EnvHandler.instance.isDevEnv){
      final finalMsg = _createLogMessage(msg, Level.info);
      _logger.i(finalMsg);
    }
  }

  static String _createLogMessage(String msg, Level level){
    final levelText = level.toString().split(".").last;
    return "[$_appName] [$levelText] $msg";
  }
}

class _CustomConsoleOutPut extends LogOutput{
  @override
  void output(OutputEvent event) {
    event.lines.forEach(debugPrint);
  }
}

class _CustomOutPut extends LogOutput{
  final LogOutput _outPuts;

  _CustomOutPut(this._outPuts);

  @override
  void output(OutputEvent event) {
    _outPuts.output(event);
  }
}
