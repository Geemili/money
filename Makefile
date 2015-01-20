VALAC=valac
MAIN=$(shell find src/main | grep ".\.vala")
TEST=$(shell find src/test | grep ".\.vala")
SRC=$(MAIN) $(TEST)
PKG= \
	--pkg gee-0.8 \
	--pkg json-glib-1.0
OUT=bin/money

all: $(OUT)

$(OUT): $(MAIN)
	valac $(MAIN) $(PKG) -o $(OUT)

run: $(OUT)
	./$(OUT)

clean:
	rm $(OUT)