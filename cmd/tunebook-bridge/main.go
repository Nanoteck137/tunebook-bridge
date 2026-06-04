package main

import (
	"os"

	bridge "github.com/nanoteck137/tunebook-bridge"
	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:     bridge.AppName,
	Version: bridge.Version,
	CompletionOptions: cobra.CompletionOptions{
		DisableDefaultCmd: true,
	},
}

func init() {
	rootCmd.SetVersionTemplate(bridge.VersionTemplate(bridge.AppName))
}

func main() {
	err := rootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}
