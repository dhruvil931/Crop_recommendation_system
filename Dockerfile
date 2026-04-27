FROM python:3.10-slim

WORKDIR /app

# System deps for pandas/sklearn + postgres driver
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy full project
COPY . .

# Expose Flask port
EXPOSE 5000

# Run backend properly (NOT dev server)
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]
