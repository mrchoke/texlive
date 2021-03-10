group "default" {
	targets = ["2020"]
}

target "2020" {
	dockerfile = "Dockerfile",
	tags = [
    "docker.io/mrchoke/texlive:latest",
    "docker.io/mrchoke/texlive:2020",
    "docker.io/mrchoke/texlive:2020.1"
    ],
  platforms = [
    "linux/amd64",
    "linux/arm64"
    ]
}

