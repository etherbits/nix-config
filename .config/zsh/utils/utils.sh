screenshotArea(){
  grimblast --freeze copysave area "$HOME/sync/screenshots/$(date +%y-%m-%d_%H-%M-%S)_screenshot.png"
}

screenshotScreen(){
  grimblast --freeze copysave output "$HOME/sync/screenshots/$(date +%y-%m-%d_%H-%M-%S)_screenshot.png"
}

if [[ "$1" == "--screenshot-area" ]]; then
  screenshotArea
elif [[ "$1" == "--screenshot-screen" ]]; then
  screenshotScreen
fi
