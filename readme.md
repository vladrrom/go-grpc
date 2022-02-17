go get github.com/golang/protobuf@v1.4

protoc -I proto proto/passwordservice.proto --go_out=plugins=grpc:proto/

go build -race -ldflags "-s -w" -o bin/server server/main.go

go build -race -ldflags "-s -w" -o bin/client client/main.go

bin/server

bin/client "gimme.a.pass"

go build -o main . / docker build -t main .

docker images

docker run -it -p 5300:5300 matzhouse/grpc-server

go build -o reverse
./reverse "this is a test"

docker-compose up
docker-compose logs -f --tail="50" vladslaves-backend

bin/client 5000
