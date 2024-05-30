from fastapi.testclient import TestClient

from .main import app

client = TestClient(app)


def test_health():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}


def test_bad_zip():
    response = client.get("/api/zipcode/1022")
    assert response.status_code == 400
