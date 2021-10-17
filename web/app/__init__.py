# -*- encoding: utf-8 -*-

# import Flask 
from flask import Flask
from dotenv import load_dotenv

load_dotenv()
app = Flask(__name__)

# App Config - the minimal footprint
app.config['TESTING'   ] = True 
app.config['SECRET_KEY'] = 'S#perS3crEt_JamesBond' 

# Import routing to render the pages
from app import views
