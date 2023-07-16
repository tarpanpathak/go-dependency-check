package main

import (
	"fmt"
	"log"
	"net/http"
)

const (
	version = "v1.0.0"
)

func checkServiceHealth() bool {
	resp, err := http.Get("https://example.com/health")

	if err != nil {
		// The service is not healthy
		return false
	}

	defer resp.Body.Close()

	return resp.StatusCode == http.StatusOK
}

func healthCheckHandler(w http.ResponseWriter, r *http.Request) {
	isHealthy := checkServiceHealth()

	if isHealthy {
		w.WriteHeader(http.StatusOK)
		fmt.Fprint(w, "Service is healthy\n")
	} else {
		w.WriteHeader(http.StatusServiceUnavailable)
		fmt.Fprint(w, "Service is not available\n")
	}
}

func main() {
	log.Println("Started the application on port 8080")

	// Register the health check handler
	http.HandleFunc("/health", healthCheckHandler)

	// Start the HTTP server
	log.Fatal(http.ListenAndServe(":8080", nil))
}
