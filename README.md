# TeXLive 2020 Full Version
This docker image support linux/amd64 and linux/arm64 you can run in macOS Docker Desktop M1 too. It can run LaTeX, pdfLaTeX, XeLaTeX, LuaLaTeX and all from TeXLive.

## Tags
* 2020, 2020.1 and latest


## Supported
* ssh server
* Python Pygments
* git client
* curl and wget

## Running

```
docker run -itd --name texlive  -v $PWD:/data -p 222:22 mrchoke/texlive
```

## SSH

```
localhost -p222 -l root
```

You can change root's password with following command.

```
docker exec -it texlive passwd
```

## Visual Studio Code

You can use Visual Studio Code (VSCode) with   Visual Studio Code Remote - SSH extension and Visual Studio Code LaTeX Workshop Extension.

