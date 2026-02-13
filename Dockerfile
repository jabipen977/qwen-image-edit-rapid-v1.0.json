# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base-cuda12.8.1

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
RUN comfy node install --exit-on-fail comfyui-kjnodes@1.2.9 --mode remote
RUN comfy node install --exit-on-fail comfyui-image-saver@1.21.0
RUN comfy node install --exit-on-fail RES4LYF
RUN comfy node install --exit-on-fail rgthree-comfy@1.0.2512112053
# Could not resolve unknown_registry/MarkdownNote - no aux_id provided, skipping
# Create extra_model_paths.yaml to point to network volume
RUN echo "comfyui:" > /comfyui/extra_model_paths.yaml && \
    echo "  checkpoints: /runpod-volume/models/checkpoints" >> /comfyui/extra_model_paths.yaml && \
    echo "  vae: /runpod-volume/models/vae" >> /comfyui/extra_model_paths.yaml && \
    echo "  text_encoders: /runpod-volume/models/text_encoders" >> /comfyui/extra_model_paths.yaml && \
    echo "  loras: /runpod-volume/models/loras" >> /comfyui/extra_model_paths.yaml && \
    echo "  embeddings: /runpod-volume/models/embeddings" >> /comfyui/extra_model_paths.yaml && \
    echo "  controlnet: /runpod-volume/models/controlnet" >> /comfyui/extra_model_paths.yaml && \
    echo "  upscale_models: /runpod-volume/models/upscale_models" >> /comfyui/extra_model_paths.yaml && \
    echo "  clip: /runpod-volume/models/clip" >> /comfyui/extra_model_paths.yaml && \
    echo "  unet: /runpod-volume/models/unet" >> /comfyui/extra_model_paths.yaml

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
