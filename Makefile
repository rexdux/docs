clean:
	rm -f ./index.html ./pages/*

index:
	sh ./generate-index.sh

html:
	sh ./generate-html.sh ./src/*

all: index html
