FROM ubuntu:12.04
MAINTAINER Dave Ashton Blackdog Internet version: 0.1
RUN apt-get update && apt-get install -y git exiv2 ffmpeg graphicsmagick python3 sqlite3 libsqlite3-dev
WORKDIR /opt
RUN git clone https://github.com/sourcefabric/Ally-Py.git -b master ally-py
WORKDIR /opt/ally-py
RUN git clone https://github.com/superdesk/Live-Blog.git -b master live-blog
RUN cd live-blog && ./build-eggs && cd distribution && python3.2 application.py -dump
WORKDIR /opt/ally-py/live-blog/distibution
ADD start.sh start.sh
RUN chmod +x start.sh
EXPOSE 8080
ENTRYPOINT /opt/ally-py/live-blog/distibution/start.sh

