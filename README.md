# fluent-bit-arm
Build for fluent-bit on raspberry pi 3.

## Building
Build this on a raspberry pi 3 with docker-engine installed.

```
$ docker build -t fluent-bit-arm .
... lots of output from the build process
Step 10 : COPY fluent-bit.conf /fluent-bit/etc/
 ---> dfeb50e56477
Removing intermediate container 6c8f950371de
Step 11 : COPY parsers.conf /fluent-bit/etc/
 ---> ca03718e3e20
Removing intermediate container 349bd9bd19bd
Step 12 : CMD /fluent-bit/bin/fluent-bit -c /fluent-bit/etc/fluent-bit.conf
 ---> Running in 46f6aeeedc04
 ---> 3448708dd6aa
Removing intermediate container 46f6aeeedc04
Successfully built 3448708dd6aa
```
This runs about 28min on my stock raspberry pi 3 with hypriot os and docker 0.12.1
