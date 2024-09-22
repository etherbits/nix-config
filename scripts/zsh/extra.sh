alias dotgitadd=""
alias dotgitadd="dotgit add ~/nix ~/.config/zellij ~/.config/ags ~/.config/hypr ~/.config/starship ~/.config/spicetify/ ~/scripts/ ~/wallpapers";
alias zj="zellij"


# find and go to directory using fzf
pc(){
  if [[ $# -eq 1 ]]; then
      selected=$1
      selected=$(find /home/etherbits/ /mnt/store/media -type d -not -path '*/.*'| fzf -q $selected -1)
  else
      selected=$(find /home/etherbits/ /mnt/store/media -type d -not -path '*/.*'| fzf)
  fi

  if [[ -z $selected ]]; then
      exit 0
  fi

  echo $selected
  cd $selected
}

pf(){
  selected=$( pc $1)
  selected_name=$(basename "$selected" | tr . _)

  cd $selected
  zellij ls -s | grep -xq $selected_name && zellij attach $selected_name || zellij -s $selected_name
}

qc(){
  git add .
  git commit -m "$1"
}

qcp(){
  git add .
  git commit -m "$1"
  branch=$(git branch --show-current)
  git push origin $branch
}

cdf(){
  dir=$(find $1 -type d | fzf -q $2)
  if [[ -n $dir ]]; then
    cd $dir
  else
    echo "No directory found"
  fi
}

ghme(){
  xdg-open https://github.com/etherbits &!
}

qcpdots(){
  dotgit add -u
  dotgit commit -m "$1"
  dotgit push origin main
}

i(){
  sudo pacman -S "$1"
}


unzipd(){
  if [[ $# != 1 ]]; then echo I need a single argument, the name of the archive to extract; return 1; fi
  target="${1%.zip}"
  unzip "$1" -d "${target##*/}"
}

unzipad(){
  for zip in *.zip
  do
    dirname=`echo $zip | sed 's/\.zip$//'`
    if mkdir "$dirname"
    then
      if cd "$dirname"
      then
        unzip ../"$zip"
        cd ..
        # rm -f $zip # Uncomment to delete the original zip file
      else
        echo "Could not unpack $zip - cd failed"
      fi
    else
      echo "Could not unpack $zip - mkdir failed"
    fi
  done
}
