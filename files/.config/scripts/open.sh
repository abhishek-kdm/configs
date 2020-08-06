#!/bin/sh

current_window=$(xdotool getwindowfocus)
PROMPT=""
PROJECTS_DIR=""
DIRMODE=false

if [ $# -eq 0 ]; then
  echo "The Force is not strong with this one!."
  exit 1;
fi

while [ $# -gt 0 ]; do
  case $1 in
    -p|--prompt)
      PROMPT="$2"
      shift;shift
      ;;
    -d|--dirmode)
      DIRMODE=true
      shift
      ;;
    *)
      [ -z $PROJECTS_DIR ] && PROJECTS_DIR=$1 || exit 1
      shift
      ;;
  esac
done

if $DIRMODE; then
  project_path=$(
    tree -idf -L 1 --noreport $PROJECTS_DIR \
      | sed "1d" \
      | dmenu -p "${PROMPT:-"open :"}" -g 1 -l 5 -w $current_window 2> /dev/null
  )
else
  file=$PROJECTS_DIR
  while $true; do
    file=$(
      tree -iaf -L 1 --dirsfirst --noreport $file \
        | sed "1d" \
        | dmenu -p "${PROMPT:-"edit :"}" -g 1 -l 5 -w $current_window 2> /dev/null
    )
    if [ -f $file ]; then
      project_path=$file
      break
    fi
  done
fi

[ ! $project_path ] && exit 0

[ -f $project_path ] && dir_path=$(dirname $project_path)

xdotool type --window $current_window "nvim -c \"cd ${dir_path:-$project_path}\" $project_path" && \
xdotool key --window $current_window Return

