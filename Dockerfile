FROM node:16

RUN apt update && apt dist-upgrade -y && \
	apt install -y wget gnupg2 && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list && \
    apt-get update && apt-get -y install google-chrome-stable libxss1

ADD ./ /app

RUN npm --prefix /app install && \
    npm --prefix /app run build && \
    rm -Rf /tmp/* && \
    rm -Rf /var/lib/apt/lists/*

WORKDIR /app

CMD npm run start
