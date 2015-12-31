FROM resin/amd64-supervisor

# Note we added the python dependencies after resin-wifi-connect's deps.
RUN apt-get update && apt-get install -y git curl build-essential bind9 bridge-utils connman iptables libdbus-1-dev libexpat-dev net-tools usbutils wireless-tools python python-dev python-dbus python-pip && rm -rf /var/lib/apt/lists/*

# Install latest version of pip
RUN curl -O https://bootstrap.pypa.io/get-pip.py && python get-pip.py

# Install Node.JS
RUN cd /usr/local && curl http://nodejs.org/dist/v0.10.40/node-v0.10.40-linux-x64.tar.gz | tar --strip-components=1 -zxf- && cd
RUN npm -g update npm

COPY ./assets/bind /etc/bind

RUN mkdir -p /usr/src/app/
WORKDIR /usr/src/app

COPY package.json ./
RUN JOBS=MAX npm install --unsafe-perm --production && npm cache clean

COPY bower.json .bowerrc ./
RUN ./node_modules/.bin/bower --allow-root install \
	&& ./node_modules/.bin/bower --allow-root cache clean

# When we COPY this folder, we're putting the python server at ./python-server
COPY . ./
RUN ./node_modules/.bin/coffee -c ./src
RUN chmod +x ./start

VOLUME /var/lib/connman

# Here we add the pip Flask package
RUN pip install flask

CMD ./start
