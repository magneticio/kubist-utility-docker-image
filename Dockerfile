FROM ubuntu:18.04

RUN apt-get update && \
    apt-get -y install apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    wget \
    software-properties-common && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
    $(lsb_release -cs) \
    stable" && \
    apt-get update && \
    apt-get -y install docker-ce

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y kubectl

RUN curl -L https://git.io/get_helm.sh | bash    

RUN KUBIST_CLI_VERSION=$(curl -s https://api.github.com/repos/magneticio/vampkubistcli/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') && \
    base=https://github.com/magneticio/vampkubistcli/releases/download/$KUBIST_CLI_VERSION && \
    curl -fsSL  $base/vamp-$(uname -s)-$(uname -m) > /usr/local/bin/vamp && \
    chmod +x /usr/local/bin/vamp

RUN useradd -ms /bin/bash vamp
USER vamp
WORKDIR /home/vamp
CMD /bin/bash