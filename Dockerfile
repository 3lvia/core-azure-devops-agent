FROM ubuntu:20.04

# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN apt-get update \
    && apt-get install --no-install-recommends \
        ca-certificates \
        curl \
        wget \
        jq \
        git \
        iputils-ping \
        libcurl4 \
        libunwind8 \
        netcat \ 
        apt-transport-https \
        git \
        zip \
        tzdata \
        software-properties-common \
        sudo \
        gnupg
        
# dotnet sdk
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install \
        dotnet-sdk-3.1 \
        dotnet-sdk-2.1 \
        dotnet-sdk-5.0


# kubectl
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update \
    && apt-get install kubectl 

# docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" \
    && apt-get update \
    && apt-get install \
        docker-ce \
        docker-ce-cli \
        containerd.io

# helm
RUN curl https://baltocdn.com/helm/signing.asc | apt-key add - \
    && echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list \
    && apt-get update \
    && apt-get install helm

# node & npm
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get update \
    && apt-get install nodejs

# openjdk-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean;
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

RUN apt-get update

WORKDIR /azp

COPY ./start_azure_devops_agent.sh .
RUN chmod +x start_azure_devops_agent.sh

# Aqua thinks this file is secret. We remove it
RUN rm -rf /var/lib/apt/lists/packages.microsoft.com_ubuntu_20.04_prod_dists_focal_InRelease

CMD ["./start_azure_devops_agent.sh"]
