FROM debian:jessie

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449 && \
    echo deb http://dl.hhvm.com/debian jessie main | tee /etc/apt/sources.list.d/hhvm.list && \
    apt-get update && apt-get install -y \
    	hhvm \
    	git && \
    apt-get clean

RUN update-rc.d hhvm defaults && \
	git clone https://gist.github.com/023964c50566ad0c5d70f8fc85217817.git /var/www/

ENTRYPOINT ["hhvm", "-m", "server", "-p", "8080", "-d", "hhvm.server.type=proxygen", "-d", "hhvm.server.source_root=/var/www"]