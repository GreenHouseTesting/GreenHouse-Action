FROM mcr.microsoft.com/playwright:focal

# Set working directory
WORKDIR /app

# Copy dependencies file
COPY ./src/dependencies.txt /app/
COPY ./src/jest.config.js /app

# Install npm dependencies
RUN cat dependencies.txt | xargs npm install

CMD ["npx", "jest"]
