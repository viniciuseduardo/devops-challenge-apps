FROM node:11-alpine

ENV HOME=/app

COPY . $HOME/

WORKDIR $HOME/

RUN yarn && yarn cache clean

CMD [ "yarn", "start" ]