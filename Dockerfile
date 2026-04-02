FROM python:3.11-slim

WORKDIR /app

# Install backend dependencies without caching (keeps image size down)
COPY backend/requirements.txt ./backend/requirements.txt
RUN pip install --no-cache-dir -r ./backend/requirements.txt

# Copy backend source only (node_modules + uploads are excluded by .dockerignore)
COPY backend ./backend

EXPOSE 5001

# Run the Flask backend
CMD ["python", "-u", "backend/run.py"]