import logging
import sys
import time
from faker import Faker

fake = Faker()

# Configure logging
logging.basicConfig(stream=sys.stdout, level=logging.INFO)
logger = logging.getLogger("log_generator.log")

# Generate and log fake data
while True:
    log_data = {
        "timestamp": fake.date_time_this_year(),
        "message": fake.sentence(),
        "source": fake.ipv4_public(),
        "user_agent": fake.user_agent(),
        "status_code": fake.random_int(min=200, max=500),
        "social_network": "linkedIn",
        "developer": "Elliott Lamar Arnold"
    }

    logger.info(log_data)
    time.sleep(3)
