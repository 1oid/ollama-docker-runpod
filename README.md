# ollama-docker-runpod for serverless

## 基于Ollama的runpod serverless docker部署容器

由于runpod serverless的vllm部署之后每次调用之前的机器启动和加载特别慢，所以选择了这种方式进行优化

优化之后的启动速度从 `3min(vllm)` 减少到了 15s(ollama gguf)之内，并且推理速度和准确度大大提升（safetensor --> gguf）
