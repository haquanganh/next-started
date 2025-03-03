# Base image
FROM node:22-alpine as Builder

# Install PNPM
RUN npm install -g pnpm

# Set working directory
WORKDIR /app

# Copy package.json and install directories
COPY package.json pnpm-lock.yaml ./
RUN pnpm install
COPY . . 
RUN pnpm build

# Use a minimal runtime edge
FROM node:22-alpine

#Set working directory
WORKDIR /app

# Install PNPM
RUN npm install -g pnpm

# Copy built files from previous page
COPY --from=Builder /app ./

#Expose the Next.js port
EXPOSE 3000

#Start Next.js in production mode
CMD ["pnpm", "start"]
