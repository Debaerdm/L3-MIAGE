#!/bin/bash

ant -v Q2-json-ad;

#java -cp ./jflex-1.6.1/java-cup-11a.jar build/Q2-json-ad/JsonAD -d ./array.json;
#java -cp ./jflex-1.6.1/java-cup-11a.jar build/Q2-json-ad/JsonAD ./sample.json;
#java -cp ./jflex-1.6.1/java-cup-11a.jar build/Q2-json-ad/JsonAD ./sample1.Json;
java -jar jflex-1.6.1/java-cup-11a.jar   build/Q2-json-ad/JsonAD ./sample1.json;
#java build/Q2-json-ad/ad/ADViewer result.ast
