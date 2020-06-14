IMAGE_NAME=osu_builder

WORKING_DIRECTORY=working
REPO_DIRECTORY=$(WORKING_DIRECTORY)/repo
BUILD_DIRECTORY=$(WORKING_DIRECTORY)/game

run: setup build | $(REPO_DIRECTORY) $(BUILD_DIRECTORY)
	cd $(REPO_DIRECTORY) && git pull && cd ../..
	docker run --rm -e DOTNET_CLI_HOME='/dotnet' -v $(PWD)/$(BUILD_DIRECTORY):/osu/ -v $(PWD)/$(REPO_DIRECTORY):/repo/ --user `id -u`:`id -g` $(IMAGE_NAME)

build:
	docker build -t $(IMAGE_NAME) .

$(WORKING_DIRECTORY)/%:
	mkdir -p $@

setup:
	-git clone https://github.com/ppy/osu.git $(REPO_DIRECTORY)

clean:
	rm -rf $(WORKING_DIRECTORY)