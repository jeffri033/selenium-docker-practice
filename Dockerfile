FROM maven:3.9.4-eclipse-temurin-17

# Install Chrome
RUN apt-get update && apt-get install -y wget unzip curl gnupg2 && \
    curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google.gpg] http://dl.google.com/linux/chrome/deb/ stable main" \
    > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get install -y google-chrome-stable

# Install matching ChromeDriver
RUN CHROME_VERSION=$(google-chrome --version | grep -oP '\d+\.\d+\.\d+') && \
    DRIVER_VERSION=$(curl -s https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json | \
        grep -oP '"Stable":.*?"version":\s*"\K[\d.]+' | head -1) && \
    wget -O /tmp/chromedriver.zip https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/${DRIVER_VERSION}/linux64/chromedriver-linux64.zip && \
    unzip /tmp/chromedriver.zip -d /usr/local/bin && \
    mv /usr/local/bin/chromedriver-linux64/chromedriver /usr/local/bin/chromedriver && \
    chmod +x /usr/local/bin/chromedriver && \
    rm -rf /tmp/chromedriver.zip /usr/local/bin/chromedriver-linux64

RUN ls -l /usr/local/bin/chromedriver && chromedriver --version


WORKDIR /app
COPY . .
CMD ["mvn", "test"]