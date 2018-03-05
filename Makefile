APP:=skydns
PKG:=github.com/skynetservices/${APP}
PWD:=${shell pwd}
GO:=CGO_ENABLED=0 GOBIN=${PWD}/bundles go

IMAGE_NAME:=registry.dpool.sina.com.cn/dpool/skydns:2.5.4
BUILD_IMG:=golang:alpine

build:
	docker run --rm -it \
	 --name $(APP)-dev \
	 -v $(PWD):/go/src/$(PKG) \
	 -w /go/src/$(PKG) \
	 ${BUILD_IMG} go build .

local:
	${GO} install .

image: build
	docker build -t ${IMAGE_NAME} .
