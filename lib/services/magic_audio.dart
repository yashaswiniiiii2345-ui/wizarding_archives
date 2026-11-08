// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:flutter/foundation.dart';

class MagicAudio {
  static void _playTone(double freq, double duration, String type) {
    if (!kIsWeb) return;
    try {
      js.context.callMethod('eval', [
        '''
        (function() {
          try {
            var AudioContext = window.AudioContext || window.webkitAudioContext;
            if (!AudioContext) return;
            if (!window._wizardAudioCtx) {
              window._wizardAudioCtx = new AudioContext();
            }
            var ctx = window._wizardAudioCtx;
            if (ctx.state === 'suspended') {
              ctx.resume();
            }
            var osc = ctx.createOscillator();
            var gain = ctx.createGain();
            osc.type = "$type";
            osc.frequency.setValueAtTime($freq, ctx.currentTime);
            gain.gain.setValueAtTime(0.01, ctx.currentTime);
            gain.gain.exponentialRampToValueAtTime(0.2, ctx.currentTime + 0.03);
            gain.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + $duration);
            osc.connect(gain);
            gain.connect(ctx.destination);
            osc.start();
            osc.stop(ctx.currentTime + $duration);
          } catch(e) {}
        })();
        '''
      ]);
    } catch (_) {}
  }

  static void playChime() {
    if (!kIsWeb) return;
    final notes = [523.25, 659.25, 783.99, 1046.50];
    for (int i = 0; i < notes.length; i++) {
      Future.delayed(Duration(milliseconds: i * 85), () {
        _playTone(notes[i], 0.35, 'sine');
      });
    }
  }

  static void playWandCast() {
    if (!kIsWeb) return;
    final notes = [880.0, 1174.66, 1760.0];
    for (int i = 0; i < notes.length; i++) {
      Future.delayed(Duration(milliseconds: i * 60), () {
        _playTone(notes[i], 0.25, 'triangle');
      });
    }
  }

  static void playSortingFanfare() {
    if (!kIsWeb) return;
    final sequence = [
      [440.0, 140],
      [554.37, 140],
      [659.25, 180],
      [880.0, 450],
    ];

    int delay = 0;
    for (final note in sequence) {
      Future.delayed(Duration(milliseconds: delay), () {
        _playTone(note[0].toDouble(), note[1] / 1000.0, 'sine');
      });
      delay += (note[1] as int);
    }
  }
}