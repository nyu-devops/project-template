# Image for a NYU Lab development environment
FROM rofrano/nyu-devops-base:fa23

# Set up the Python development environment
WORKDIR /app
COPY pyproject.toml poetry.lock ./
RUN python -m pip install poetry && \
    poetry config virtualenvs.create false && \
    poetry install

# Install user mode tools
COPY .devcontainer/scripts/install-tools.sh /tmp/
RUN cd /tmp && bash ./install-tools.sh
