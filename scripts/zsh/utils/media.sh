incVol(){
  pamixer --allow-boost --set-limit 100 -i $1
  showVol
}

decVol(){
  pamixer --allow-boost -d $1
  showVol
}

toggleAudioMute(){
  pamixer --toggle-mute
  showVol
}

toggleMicMute(){
  pamixer --default-source --toggle-mute
  showMic
}


if [[ "$1" == "--inc" ]]; then
	incVol $2
elif [[ "$1" == "--dec" ]]; then
	decVol $2
elif [[ "$1" == "--toggle-audio-mute" ]]; then
	toggleAudioMute
elif [[ "$1" == "--toggle-mic-mute" ]]; then
	toggleMicMute
fi
