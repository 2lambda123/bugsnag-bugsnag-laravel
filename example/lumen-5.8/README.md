# Bugsnag Lumen 5.8 demo

This Lumen application demonstrates how to use Bugsnag with version 5.8 of the Lumen micro framework for PHP.

## Setup

Try this out with [your own Bugsnag account](https://app.bugsnag.com/user/new), and you'll be able to see how the errors are reported directly in the dashboard.

To get set up, follow the instructions below. Don't forget to replace the placeholder API token with your own!

1. Clone the repo and `cd` into this directory:
    ```shell
    git clone https://github.com/bugsnag/bugsnag-laravel.git
    cd bugsnag-laravel/example/lumen-5.8
    ```

1. Install dependencies
    ```shell
    composer install
    ```

1. Copy the `.env.example` file to `.env`
    ```shell
    cp .env.example .env
    ```

1. Set the `BUGSNAG_API_KEY` in `.env` to your Bugsnag project's API Key

1. Run the application.
    ```shell
    php -S localhost:8000 -t public/
    ```

1. View the example page which will be served at: http://localhost:8000

For more information, see [our Lumen documentation](https://docs.bugsnag.com/platforms/php/lumen/).
