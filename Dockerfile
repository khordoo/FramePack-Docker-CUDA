# Base image with CUDA 12.6 (compatible with Torch 2.6's CUDA 12.4 requirements)
FROM nvidia/cuda:12.6.0-devel-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    VIRTUAL_ENV=/venv \
    PATH="/venv/bin:$PATH" \
    LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    python3.10 \
    python3.10-venv \
    python3.10-dev \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

# Create virtual environment
RUN python3.10 -m venv $VIRTUAL_ENV

# Install PyTorch 2.6.0 with CUDA 12.4 compatibility (works with 12.6 base)
RUN pip install --no-cache-dir \
    torch==2.6.0 \
    torchvision \
    torchaudio \
    --index-url https://download.pytorch.org/whl/cu124

# Clone FramePack (Torch 2.6 compatible version)
RUN git clone https://github.com/lllyasviel/FramePack /app && \
    cd /app

WORKDIR /app

# Install requirements
RUN pip install --no-cache-dir -r requirements.txt

# Install additional dependencies
RUN pip install --no-cache-dir \
    triton==3.0.0 \
    sageattention==1.0.6

# Model directory setup
RUN mkdir -p /app/hf_download && \
    chmod -R 777 /app/hf_download

VOLUME /app/hf_download

# Expose output directory
RUN mkdir -p /app/outputs && \
    chmod -R 777 /app/outputs

VOLUME /app/outputs

# Runtime configuration
EXPOSE 7860
CMD ["python", "demo_gradio.py", "--share"]
