watch source="~/src/JYUHQ/TIL/":
  fswatch -o {{source}} | xargs -n1 -I{} just sync {{source}}

sync source="~/src/JYUHQ/TIL/":
  rsync -av --delete {{source}} ./content/
  npx prettier -w ./content/
  rsync -av ./content/ {{source}}

dev:
  npx quartz build --serve
