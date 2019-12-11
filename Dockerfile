# use a node image
FROM node:6.14.2

# tell docker what port to expose
EXPOSE 8080

# Copy the file server.js
COPY server.js .

CMD node server.js
