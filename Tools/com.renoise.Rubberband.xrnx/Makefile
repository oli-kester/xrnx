PACKAGE_NAME=`pwd | xargs -i% basename % .xrnx | sed -e 's/\./_/g'`
VERSION_NO=`grep '<Version>' manifest.xml | sed 's/.*>\(.*\)<.*/\1/' | sed -e 's/\./_/g'`
TARGET=$(shell echo $(PACKAGE_NAME)_V$(VERSION_NO).xrnx)
FILES=manifest.xml *.lua bin/

$(TARGET): $(FILES)
	zip -r $(TARGET) $(FILES) -x \*/.svn/\*

clean:
	rm *.xrnx
