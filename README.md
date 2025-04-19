## FramePack Docker CUDA

Very easy:

```

git clone https://github.com/akitaonrails/FramePack-Docker-CUDA.git
cd FramePack-Docker-CUDA
mkdir outputs
mkdir hf_download

# Build the image
docker build -t framepack-torch26-cu124:latest .

# Run mapping the directories outside:
docker run -it --rm --gpus all -p 7860:7860 \
  -v ./outputs:/app/outputs \
  -v ./hf_download:/app/hf_download \
  framepack-torch26-cu124:latest
```

The first time it runs, it will download all necessary HunyuanVideo, Flux and other neccessary models. It will be more than 30GB, so be patient, but they will be cached on the external mapped directory.

When it finishes access http://localhost:7860 and that's it!
