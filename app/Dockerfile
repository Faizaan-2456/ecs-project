# Build stage: AS builder sets the build stage called builder
FROM node:25-alpine AS builder

# Setting the working directory inside image
WORKDIR /app

# Copying app dependencies into image
COPY package.json yarn.lock

# Copying rest of source code into image
COPY . .

# Downloads and installs app dependencies
RUN yarn install

# builds app into production ready files
RUN yarn build 

#---Runtime stage---

# new stage. makes image lightweight
FROM node:25-alpine

# sets working directory to /app
WORKDIR /app

# copies production files from build stage 
COPY --from=builder /app/build /app/build

# Copies html files needed to serve the public application
COPY --from=builder /app/public /app/public

# Installs package globally on system and 'serve' is the executable that starts the web server
RUN yarn global add serve

EXPOSE 3000

# serve is the executable yarn uses to serve the application 
CMD [ "serve", "-s", "build" ]