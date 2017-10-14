FROM python:3
WORKDIR /app
ADD . /app
RUN pip install -r requirements.txt
EXPOSE 8000
CMD ["gunicorn", "-b 0.0.0.0", "server:app"]
