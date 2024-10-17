FROM python:3.9-slim

# Install SnowSQL CLI and other dependencies
RUN apt-get update && \
    apt-get install -y curl && \
    curl -O https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/latest/snowsql-linux_x86_64.zip && \
    unzip snowsql-linux_x86_64.zip && \
    ./snowsql_install.sh --accept-license --skip-installation && \
    rm -rf snowsql-linux_x86_64.zip snowsql_install.sh

# Set the working directory
WORKDIR /app

# Copy the Streamlit app and requirements
COPY app.py .
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Command to run the Streamlit app
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
