.PHONY: test testacc build clean release release_bump release_build

test:
	go test -v $(shell go list ./... | grep -v /vendor/)

testacc:
	go clean -testcache; TF_ACC=1 go test -v ./plugin/providers/phpipam -run="TestAcc"

build:
	GOOS=linux GOARCH=amd64 go build -ldflags "-X google.golang.org/protobuf/reflect/protoregistry.conflictPolicy=warn" -o terraform.d/plugins/registry.terraform.io/lord-kyron/phpipam/1.7.0/linux_amd64/terraform-provider-phpipam
	GOOS=linux GOARCH=arm64 go build -ldflags "-X google.golang.org/protobuf/reflect/protoregistry.conflictPolicy=warn" -o terraform.d/plugins/registry.terraform.io/lord-kyron/phpipam/1.7.0/linux_arm64/terraform-provider-phpipam
	GOOS=darwin GOARCH=amd64 go build -ldflags "-X google.golang.org/protobuf/reflect/protoregistry.conflictPolicy=warn" -o terraform.d/plugins/registry.terraform.io/lord-kyron/phpipam/1.7.0/darwin_amd64/terraform-provider-phpipam
	GOOS=darwin GOARCH=arm64 go build -ldflags "-X google.golang.org/protobuf/reflect/protoregistry.conflictPolicy=warn" -o terraform.d/plugins/registry.terraform.io/lord-kyron/phpipam/1.7.0/darwin_arm64/terraform-provider-phpipam

release: release_bump release_build

release_bump:
	scripts/release_bump.sh

clean:
	rm -rf .terraform.d/plugins

fmt:
	gofmt -s -w -e .
