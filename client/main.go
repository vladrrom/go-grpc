package main

import (
	"context"
	"log"
	"os"
	"time"

	ps "netangels/passwordservice/proto"

	"google.golang.org/grpc"
)

func main() {

	conn, _ := grpc.Dial("127.0.0.1:8080", grpc.WithInsecure())
	start := time.Now()
	client := ps.NewPasswordGeneratorServiceClient(conn)

	sample := os.Args[1]

	resp, err := client.Generate(context.Background(),
		&ps.PasswordRequest{Sample: sample})

	if err != nil {
		log.Fatalf("could not get answer: %v", err)
	}
	log.Println("New password:", resp.Password)
	duration := time.Since(start)
	log.Println(duration)
}
