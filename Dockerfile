FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1

# Install system dependencies needed for OpenCV/av/ffmpeg
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential ffmpeg libsm6 libxext6 pkg-config \
       libavformat-dev libavcodec-dev libavdevice-dev libavutil-dev libavfilter-dev libswscale-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Python dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy application
COPY . /app

EXPOSE 8501

CMD ["streamlit", "run", "app_webcam.py", "--server.port=8501", "--server.enableCORS=false"]
