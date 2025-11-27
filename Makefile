clean:
	rm -f ./pages/*

index:
	sh ./generate-index.sh

html:
	sh ./generate-html.sh ./src/*

all: clean index html
