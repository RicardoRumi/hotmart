"""Base example application."""
import socket

import flask

from flask import Flask, jsonify, render_template_string


def create_app():
    app = flask.Flask(__name__)

    @app.route('/health')
    def base_healthcheck_route():
        """Healthcheck route."""
        return {"message": "flask is operational", "error": False}, 200

    @app.route('/')
    def index():
        """Example route."""
        message = f"Hello from {socket.gethostname()}"
        return {"message": message}, 200
    
    @app.route('/backend')
    def backend():
        """Backend route with a different background color."""
        html = """
        <html>
            <body style="background-color: lightblue; color: black; font-family: Arial, sans-serif; text-align: center; padding: 20px;">
                <h1>Backend Route</h1>
                <p>This is the backend service. Running on {{ hostname }}</p>
            </body>
        </html>
        """
        return render_template_string(html, hostname=socket.gethostname())

    @app.route('/frontend')
    def frontend():
        """Frontend route with a different background color."""
        html = """
        <html>
            <body style="background-color: lightgreen; color: black; font-family: Arial, sans-serif; text-align: center; padding: 20px;">
                <h1>Frontend Route</h1>
                <p>This is the frontend service. Running on {{ hostname }}</p>
            </body>
        </html>
        """
        return render_template_string(html, hostname=socket.gethostname())

    return app

def main():
    """Main entrypoint."""
    app = create_app()
    app.run(debug=True, host="0.0.0.0", port=80)


if __name__ == "__main__":
    main()
