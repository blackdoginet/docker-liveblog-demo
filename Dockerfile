FROM ubuntu:12.04
MAINTAINER Dave Ashton Blackdog Internet version: 0.1
RUN apt-get update && apt-get install -y git exiv2 ffmpeg graphicsmagick python3 sqlite3 libsqlite3-dev
WORKDIR /opt
RUN git clone https://github.com/sourcefabric/Ally-Py.git -b master ally-py
WORKDIR /opt/ally-py
RUN git clone https://github.com/superdesk/Live-Blog.git -b master live-blog
RUN cd live-blog && ./build-eggs && cd distribution && python3.2 application.py -dump
WORKDIR /opt/ally-py/live-blog/distribution
RUN touch start.sh
RUN echo '#!/bin/bash' >>start.sh && \
	echo "myip=$(hostname -I | xargs)" >> start.sh && \
	echo 'sed -i -- "s/localhost/$myip/g" plugins.properties' >> start.sh && \
	echo 'python3.2 application.py' >> start.sh && \
	chmod +x start.sh
EXPOSE 8080
ENTRYPOINT /opt/ally-py/live-blog/distribution/start.sh

