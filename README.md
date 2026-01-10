# Sumber Gateway

## Installation

1. Clone the repository:
    ```bash
    git clone sumber-gateway
    ```
2. Navigate to the project directory:
    ```bash
    cd sumber-gateway
    ```
3. Run the setup script to create the Docker network & start docker containers:
    ```bash
    ./setup.sh
    ```
4. Access the application at `https://{your-server-ip}`. if return 404 it is means the gateway is running properly.

## Add New Host/Domain

1. Edit the `lua/router.lua` file to add your new host/domain and its corresponding target service.
2. Changes will take effect immediately without needing to restart the gateway. Access your new host/domain to verify it is working correctly.

_Note: Ensure your new target service is running and accessible within the Docker network (sumber-network)._
