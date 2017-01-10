#!/bin/sh

java -cp ../lib/java-cup-11b-runtime.jar:microcobol.jar:. TestParser $1
