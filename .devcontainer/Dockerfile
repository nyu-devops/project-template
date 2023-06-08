# Image for a NYU Lab development environment
FROM rofrano/nyu-devops-base:su23

## Uncomment below lines to add Selenium for BDD
# RUN sudo apt-get update && \
#     sudo apt-get install -y chromium-driver python3-selenium && \
#     sudo apt-get autoremove -y && \
#     sudo apt-get clean -y

# Set up the Python development environment
WORKDIR /app
COPY requirements.txt .
RUN sudo pip install -r requirements.txt

# Install user mode tools
COPY .devcontainer/scripts/install-tools.sh /tmp/
RUN cd /tmp && bash ./install-tools.sh
