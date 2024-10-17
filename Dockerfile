# Use an official base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    unzip && \
    curl -O https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/latest/snowsql-linux_x86_64.zip && \
    unzip snowsql-linux_x86_64.zip && \
    ./snowsql_install.sh --accept-license --skip-installation && \
    rm -rf snowsql-linux_x86_64.zip snowsql_install.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy your Streamlit app files into the container
COPY app.py .

# Command to run your Streamlit app
CMD ["snowsql", "--version"]  # Replace this with the actual command to run your Streamlit app
