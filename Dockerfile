# Start with the official pre-built image to save compilation time
FROM langflowai/langflow:latest

# Switch to root to ensure we have permission to install our custom code
USER root

# Create a directory for our custom code
WORKDIR /app/custom_langflow

# Copy your customized GitHub codebase into the container
COPY . .

# Force install your local, modified version of Langflow over the default one
RUN pip install -e .

# Run your customized framework
CMD ["python", "-m", "langflow", "run", "--host", "0.0.0.0", "--port", "7860"]
