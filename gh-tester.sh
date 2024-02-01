#!/bin/bash

# FOR HEADED TESTING

IMAGE_NAME="greenhouse-tester"

CODE_PATH=$1

echo "Generating Dockerfile for Jest/Playwright tests..."

# Create Dockerfile
cat <<EOF > Dockerfile
FROM mcr.microsoft.com/playwright:focal

# Set working directory
WORKDIR /app

# Copy dependencies file
COPY ./src/dependencies.txt /app/
COPY ./src/jest.config.js /app

# Install npm dependencies
RUN cat dependencies.txt | xargs npm install

CMD ["npx", "jest"]
EOF

echo "Building Docker image..."
docker build -t $IMAGE_NAME .

if [ $? -ne 0 ]; then
    echo "Docker build failed"
    exit 1
fi

echo "Running tests using Docker..."
docker run -it -v $CODE_PATH:/app/tests $IMAGE_NAME

if [ $? -ne 0 ]; then
    echo "Tests failed"
    exit 1
fi

rm -f Dockerfile

echo "Tests completed successfully"
