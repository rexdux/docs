clean:
	rm -f ./index.html ./pages/*

html:
	sh ./generate-html.sh ./src/*

all: clean html
