watch source="~/src/JYUHQ/TIL/":
  fswatch -o {{source}} | xargs -n1 -I{} just sync {{source}}

sync source="~/src/JYUHQ/TIL/":
  rsync -av --delete {{source}} ./content/

dev:
  npx quartz build --serve
