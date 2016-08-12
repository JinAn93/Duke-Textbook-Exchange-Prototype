# Duke-Textbook-Exchange

## Requirements for Eclipse

* Java Spring
* Tomcat or jetty etc
* Hibernate


## Documentation
   ####[Product Backlog](https://docs.google.com/document/d/1lZ-HzBv-RrjMBs_xLMB4TRq1MqRjlJuirz3ivwc4aIM/edit)


## Issue notes

###Maven build error command line
OS (Mac): 
find ~/.m2  -name "*.lastUpdated" -exec grep -q "Could not transfer" {} \; -print -exec rm {} \;

OS (Windows):
cd %userprofile%\.m2\repository
for /r %i in (*.lastUpdated) do del %i

###Spring Annotation Mapping
http://www.mkyong.com/spring3/spring-3-mvc-hello-world-example-annotation/


## Reference
http://www.awwwards.com/
https://www.materialpalette.com/
