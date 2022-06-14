from flask import *
import os

# Initialize Flask App
app = Flask(__name__)

@app.route('/list',methods=["POST", "GET"])
def main():
    return

port = int(os.environ.get('PORT', 8080))
if __name__ == '__main__':
    app.run(threaded=True,port=port,debug=True)