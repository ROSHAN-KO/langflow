# Start with the official pre-built image
FROM langflowai/langflow:latest

# Switch to root to ensure we have permissions
USER root
WORKDIR /app/custom_langflow

# 1. SAVE THE UI: Back up the compiled frontend from the official image
RUN cp -r /app/.venv/lib/python3.12/site-packages/langflow/frontend /tmp/frontend_backup

# 2. COPY YOUR CODE: Bring in your customized GitHub codebase
COPY . .

# 3. INSTALL YOUR TWEAKS: Install your modified backend (removed '-e' for a clean install)
RUN /app/.venv/bin/pip install .

# 4. RESTORE THE UI: Put the frontend back exactly where the server expects it
RUN cp -r /tmp/frontend_backup /app/.venv/lib/python3.12/site-packages/langflow/frontend

# Run your customized framework
CMD ["/app/.venv/bin/python", "-m", "langflow", "run", "--host", "0.0.0.0", "--port", "7860"]
