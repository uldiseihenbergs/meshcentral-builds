FROM node:14-slim
RUN apt-get update && apt-get -y install libcap2-bin \
  && rm -rf /var/lib/apt/lists/* \
  && setcap cap_net_bind_service=+ep '/usr/local/bin/node'
RUN mkdir -p /home/node/meshcentral/node_modules && chown -R node:node /home/node/meshcentral
USER node
WORKDIR /home/node/meshcentral
COPY package*.json ./
RUN npm install meshcentral@0.9.59

ENTRYPOINT node ./node_modules/meshcentral/meshcentral.js
