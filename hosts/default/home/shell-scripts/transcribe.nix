{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellScriptBin "transcribe" ''
      MODEL=$1
      WAVFILE="/tmp/whisper.wav"

      if test ! -f "$WAVFILE"; then
        ${pkgs.notify-desktop}/bin/notify-desktop "Recording audio" "Re-trigger the shortcut to transcribe"
        nohup pw-record $WAVFILE &
        disown -a
        exit
      fi

      ${pkgs.busybox}/bin/fuser -k -INT "$WAVFILE"
      ${pkgs.notify-desktop}/bin/notify-desktop "Starting transcription" "using model $MODEL"
      ${pkgs.whisper-cpp}/bin/whisper-cli -m "$MODEL" -f "$WAVFILE" --output-txt
      tr -d '\n' < /tmp/whisper.wav.txt | wl-copy
      rm "$WAVFILE"
      ydotool key 29:1 47:1 47:0 29:0
    '')
  ];
}
