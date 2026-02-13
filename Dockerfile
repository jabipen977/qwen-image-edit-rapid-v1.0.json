# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
RUN comfy node install --exit-on-fail comfyui-kjnodes@1.2.9 --mode remote
RUN comfy node install --exit-on-fail comfyui-image-saver@1.21.0
RUN comfy node install --exit-on-fail RES4LYF
RUN comfy node install --exit-on-fail rgthree-comfy@1.0.2512112053
# Could not resolve unknown_registry/MarkdownNote - no aux_id provided, skipping

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Phr00t/Qwen-Image-Edit-Rapid-AIO/blob/5b72f3eff4a37bb4d7f0ba3b2d783c34b6bc3988/v11/Qwen-Rapid-AIO-NSFW-v11.4.safetensors --relative-path models/checkpoints --filename Qwen-Rapid-AIO-NSFW-v11.4.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
