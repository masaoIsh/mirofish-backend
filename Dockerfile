FROM python:3.11-slim

# Copy uv into the image
COPY --from=ghcr.io/astral-sh/uv:0.9.26 /uv /uvx /bin/

WORKDIR /app

# Install only Python backend dependencies
COPY backend/pyproject.toml backend/uv.lock ./backend/
RUN cd backend && uv sync --frozen --no-dev

# Copy only the backend source (no frontend build artifacts)
COPY backend ./backend

EXPOSE 5001

# Run the Flask backend (port controlled by env: FLASK_PORT, default 5001)
CMD ["sh", "-c", "cd backend && uv run python run.py"]