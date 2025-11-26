html:
	sh ./generate-html.sh ./src/*

clean:
	rm -f ./pages/*

all: clean html
