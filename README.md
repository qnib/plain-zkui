# plain-zkui
Plain zkui image using a defined commit from [DeemOpen/zkui](https://github.com/DeemOpen/zkui).

## Build master

```bash
$ docker build --build-arg=ZKUI_COMMIT=master -t qnib/plain-zkui:master .
*snip*
Successfully tagged qnib/plain-zkui:master
$ docker inspect -f '{{range $key, $val :=.ContainerConfig.Labels}}{{$key}}:{{$val}} {{end}}' qnib/plain-zkui:master
zkui.commit:master zkui.maven.version:3.3.9
$
```
