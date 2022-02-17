FROM golang:latest as builder

#ADD . .

COPY . /go/src
WORKDIR /go/src
COPY go.mod .
COPY go.sum .
RUN go mod vendor

#RUN apt-get update
#RUN apt-get install -y git
#RUN go get github.com/michaelbironneau/garbler/lib
#RUN go mod init netangels/passwordservice
#RUN go get google.golang.org/grpc
#RUN go get github.com/golang/protobuf/protoc-gen-go
#RUN go build -o server .


RUN cd main && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o passgenerator_with_grpc .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/main/passgenerator_with_grpc .
ENTRYPOINT ["./passgenerator_with_grpc"]

EXPOSE 8080

CMD ["/server"]