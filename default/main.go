package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func main() {
	http.Handle("/", http.FileServer(http.Dir("ng-web/dist/ng-web")))

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
		log.Printf("Defaulting to port %s", port)
	}

	log.Printf("Listening on port %s", port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), nil))
}
