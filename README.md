# FramePack Docker CUDA This repository provides a Docker setup to run FramePack on Linux with CUDA support. 
## 🚀 Quick Start 
1. **Clone the repository and navigate into it:**
2. ```bash git clone https://github.com/akitaonrails/FramePack-Docker-CUDA.git cd FramePack-Docker-CUDA ```
3. 2. **Make the setup script executable:**
   3. ```bash chmod +x setup.sh ```
   4. 3. **Run the setup script:**
      4. ```bash ./setup.sh ```
   This script will:
   - Install Docker and its dependencies.
   - Add your user to the `docker` group.
   - Clone the `FramePack-Docker-CUDA` repository.
   - Create necessary directories (`outputs` and `hf_download`).
   - Build the Docker image. - Run the Docker container with appropriate volume mappings.
 4. **Access the application:**
    Once the container is running, open your browser and navigate to:
    ``` http://localhost:7860 ```
    The first time it runs, it will download all necessary models (e.g., HunyuanVideo, Flux), which may exceed 30GB. These will be cached in the `hf_download` directory for future use.
## 📝 Notes - Ensure you have an NVIDIA GPU and the necessary drivers installed on your host machine. 
- If you encounter permission issues with Docker, you may need to log out and log back in or run `newgrp docker` to apply group changes. For more details, refer to the official Docker installation guide for Ubuntu: https://docs.docker.com/engine/install/ubuntu/
