package main

import (
	"fmt"
	"os/exec"
	"strings"
)

func main() {
	// Lista de herramientas que pusimos en REQUISITOS.md
	tools := []string{"nvim", "go", "lazygit", "magick", "fd", "rg", "psql"}

	fmt.Println("🔎 Verificando Entorno de Juan Carlos...")
	fmt.Println(strings.Repeat("-", 40))

	for _, tool := range tools {
		// exec.LookPath busca el binario en el PATH de Windows
		path, err := exec.LookPath(tool)
		if err != nil {
			fmt.Printf("❌ %-10s: No encontrado\n", tool)
		} else {
			fmt.Printf("✅ %-10s: Instalado en %s\n", tool, path)
		}
	}

	fmt.Println(strings.Repeat("-", 40))
	fmt.Println("¡Si falta algo, corre install_everything.ps1!")
}
