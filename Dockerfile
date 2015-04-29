FROM ubuntu:14.04
MAINTAINER Bill Conn <Bill.Conn@usd.edu>

RUN apt-get update && apt-get install -y default-jre-headless
COPY executables/ /opt/
RUN mv /opt/ParaABioS/ParaABioS /usr/local/bin
RUN mv /opt/SBMLCompare/SBMLCompare /usr/local/bin
RUN mv /opt/SBMLChecker/SBMLChecker /usr/local/bin
RUN mv /opt/SBMLMerge/SBMLMerge /usr/local/bin
RUN mv /opt/SBMLSplit/SBMLSplit /usr/local/bin
RUN mv /opt/SBMLAnnotate/SBMLAnnotate /usr/local/bin
RUN mv /opt/SBMLModeler/SBMLModeler /usr/local/bin
