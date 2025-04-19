#!/bin/bash
set -e

# Check for required models
MODEL_CHECKLIST=(
  "/app/models/checkpoints/sd_xl_base_1.0.safetensors"
  "/app/models/upscale_models/realesr-general-x4v3.pth"
)

for model in "${MODEL_CHECKLIST[@]}"; do
  if [ ! -f "$model" ]; then
    echo "ERROR: Missing required model: $model"
    echo "Either mount volumes or rebuild image with model downloads"
    exit 1
  fi
done

exec python demo_gradio.py --share --server-name 0.0.0.0
