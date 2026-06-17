#!/bin/bash
streamlit run app_webcam.py --server.port=${PORT:-8501} --server.enableCORS=false
