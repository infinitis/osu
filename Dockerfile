FROM debian:latest

RUN apt-get update
RUN apt-get install -y git wget gpg apt-transport-https

# Install dotnet core
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
RUN mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
RUN wget -q https://packages.microsoft.com/config/debian/9/prod.list
RUN mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
RUN chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
RUN chown root:root /etc/apt/sources.list.d/microsoft-prod.list
RUN apt-get update
RUN apt-get install dotnet-sdk-3.1

USER osu
WORKDIR /home/osu

RUN git clone https://github.com/ppy/osu

WORKDIR /home/osu/osu

ENV DOTNET_CLI_HOME=/home

CMD dotnet publish -c Release --self-contained -r linux-x64 -o /osu osu.Desktop