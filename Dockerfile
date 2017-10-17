FROM openjdk:8-jre-alpine

ENV JMETER_VERSION=3.3
ENV JMETER_HOME=/opt/jmeter
ENV JMETER_DIR=${JMETER_HOME}/apache-jmeter-${JMETER_VERSION}

RUN apk add --no-cache openssl ca-certificates wget

WORKDIR ${JMETER_HOME}

RUN wget -qO- http://ftp.ps.pl/pub/apache//jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz | tar xvz && \
    wget -P ${JMETER_DIR}/lib/ext https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-manager/0.10/jmeter-plugins-manager-0.10.jar && \
    wget -P ${JMETER_DIR}/lib https://repo1.maven.org/maven2/kg/apc/cmdrunner/2.0/cmdrunner-2.0.jar && \
    java -cp ${JMETER_DIR}/lib/ext/jmeter-plugins-manager-0.10.jar org.jmeterplugins.repository.PluginManagerCMDInstaller

RUN ${JMETER_DIR}/bin/PluginsManagerCMD.sh install jpgc-casutg,jpgc-graphs-basic,jpgc-graphs-composite,jpgc-graphs-vs,jpgc-graphs-additional,jpgc-ggl,jpgc-cmd,jpgc-synthesis,jpgc-graphs-dist

RUN ln -s ${JMETER_DIR}/bin/jmeter /usr/bin/jmeter

COPY user.properties $(JMETER_DIR)/bin/user.properties

WORKDIR /jmeter

EXPOSE 4445
ENTRYPOINT ["jmeter"]
