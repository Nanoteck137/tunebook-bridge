package main

import (
	"fmt"

	"github.com/kr/pretty"
	"github.com/nanoteck137/tunebook-bridge/api"
)

func main() {
	client := api.New("http://10.28.28.212:3000")

	tracks, err := client.GetTracks(api.Options{})
	if err != nil {
		fmt.Println("err:", err)
		return
	}

	pretty.Println(tracks)
}
