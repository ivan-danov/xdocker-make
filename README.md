# xdocker-make

```
for di in $(docker images --filter=reference='xdockermake/*:latest' --format "table {{.Repository}}"|grep -v REPOSITORY); do
        did=${di#xdockermake/}
        alias xdocker-make-${did%-devel}="~/src/xdocker-make/xdocker-make ${di}:latest"
done
```
