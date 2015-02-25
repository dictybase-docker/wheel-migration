package main

import (
	"io/ioutil"
	"log"
	"os"
	"path/filepath"

	"gopkg.in/codegangsta/cli.v1"
	"gopkg.in/yaml.v1"
)

func ValidateMultiArgs(c *cli.Context) bool {
	if c.Generic("muser") == nil {
		return false
	}
	if c.Generic("mpassword") == nil {
		return false
	}
	return true
}

func ValidateArgs(c *cli.Context) bool {
	if c.Generic("dsn") == nil {
		return false
	}
	if c.Generic("user") == nil {
		return false
	}
	if c.Generic("password") == nil {
		return false
	}
	return true
}

func ValidateExtraArgs(c *cli.Context) bool {
	if c.Generic("legacy-dsn") == nil {
		return false
	}
	if c.Generic("legacy-user") == nil {
		return false
	}
	if c.Generic("legacy-password") == nil {
		return false
	}
	return true
}

func CreateRequiredFolder(folder string) {
	if _, err := os.Stat(folder); os.IsNotExist(err) {
		if err := os.Mkdir(folder, 0744); err != nil {
			log.Fatal(err)
		}
	}
}

func CreateSCFolder(yf string) {
	b, err := ioutil.ReadFile(yf)
	if err != nil {
		log.Fatal(err)
	}
	var yml StockCenterConfig
	if err := yaml.Unmarshal(b, &yml); err != nil {
		log.Fatal(err)
	}
	CreateRequiredFolder(filepath.Dir(yml.LogFile))
}

func CreateFolderFromYaml(yf string) {
	b, err := ioutil.ReadFile(yf)
	if err != nil {
		log.Fatal(err)
	}
	var yml GFF3Config
	if err := yaml.Unmarshal(b, &yml); err != nil {
		log.Fatal(err)
	}
	CreateRequiredFolder(filepath.Dir(yml.Output))
	CreateRequiredFolder(filepath.Dir(yml.LogFile))
}
