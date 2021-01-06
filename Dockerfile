FROM continuumio/miniconda:4.7.10
MAINTAINER <christoph.hahn@uni-graz.at>

ENV PATH /opt/conda/bin:$PATH

#install necessary libs
RUN apt-get update && apt-get install -y libssl-dev libssl1.1
#rename library files to the expected
RUN cd /lib/x86_64-linux-gnu/ && \
	ln -s libss.so.2 libssl.so.1.0.0 && \
	ln -s libcrypt.so.1 libcrypto.so.1.0.0

#install packages
RUN conda config --append channels bioconda && \
	conda install -y -c bioconda/label/cf201901 ucsc-genepredtobed=357 ucsc-gtftogenepred=357 && \
	conda clean -a -y

CMD ["genePredToBed"]


