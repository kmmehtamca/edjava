# Use Ubuntu as the base image
FROM ubuntu:20.04

# Update packages and install necessary tools
  RUN apt-get update && \
    apt-get install -y wget && \
    apt-get clean

# Download and install JDK 17
RUN wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - && \
    echo "deb https://adoptopenjdk.jfrog.io/adoptopenjdk/deb focal main" | tee /etc/apt/sources.list.d/adoptopenjdk.list && \
    apt-get update && \
    apt-get install -y adoptopenjdk-17-hotspot && \
    apt-get clean


# Set environment variables
ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# Download and extract Apache Tomcat
WORKDIR /tmp
ADD https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.18/bin/apache-tomcat-10.1.18.tar.gz /tmp
RUN tar -xf apache-tomcat-10.1.18.tar.gz && \
    mv apache-tomcat-10.1.18. $CATALINA_HOME && \
    rm apache-tomcat-10.1.18.tar.gz

# Copy the WAR file to the webapps directory
#COPY target/ABCtechnologies-1.0.war  $CATALINA_HOME/webapps/
#COPY "/var/lib/jenkins/workspace/CI_CD_PipelineGiT/target/ABCtechnologies-1.0.war" \
    # "$CATALINA_HOME/webapps/"
#COPY /var/lib/jenkins/workspace/CI_CD_PipelineGiT/target/ABCtechnologies-1.0.war $CATALINA_HOME/webapps/
 #COPY "/var/lib/jenkins/workspace/CI_CD_PipelineGiT/target/ABCtechnologies-1.0.war" "$CATALINA_HOME/webapps/"
# ADD "/var/lib/jenkins/workspace/CI_CD pipleline/target/ABCtechnologies-1.0.war" "$CATALINA_HOME/webapps/ABCtechnologies-1.0.war"

COPY target/ABCtechnologies-1.0.war $CATALINA_HOME/webapps/
                   
# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
