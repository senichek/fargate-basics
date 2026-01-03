python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt


docker build -t fargate-demo .
docker run -p 8080:8080 fargate-demo
curl http://localhost:8080/health
